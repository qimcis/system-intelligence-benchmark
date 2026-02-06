#!/bin/bash
set -e

cd /workspace/ostep-projects/concurrency-xv6-threads/src

cat <<'PATCH' | patch -p1
diff -ruN -x .git a/defs.h b/defs.h
--- a/defs.h	2026-01-31 13:48:34.360722856 -0500
+++ b/defs.h	2026-01-31 13:48:45.602760516 -0500
@@ -106,6 +106,7 @@
 int             cpuid(void);
 void            exit(void);
 int             fork(void);
+int             clone(void (*)(void *, void *), void *, void *, void *);
 int             growproc(int);
 int             kill(int);
 struct cpu*     mycpu(void);
@@ -117,6 +118,7 @@
 void            setproc(struct proc*);
 void            sleep(void*, struct spinlock*);
 void            userinit(void);
+int             join(void **);
 int             wait(void);
 void            wakeup(void*);
 void            yield(void);
diff -ruN -x .git a/Makefile b/Makefile
--- a/Makefile	2026-01-31 13:48:34.360722856 -0500
+++ b/Makefile	2026-01-31 13:49:56.581992935 -0500
@@ -153,7 +154,7 @@
 _forktest: forktest.o $(ULIB)
 	# forktest has less library code linked in - needs to be small
 	# in order to be able to max out the proc table.
-	$(LD) $(LDFLAGS) -N -e main -Ttext 0 -o _forktest forktest.o ulib.o usys.o
+	$(LD) $(LDFLAGS) -N -e main -Ttext 0 -o _forktest forktest.o ulib.o usys.o umalloc.o
 	$(OBJDUMP) -S _forktest > forktest.asm
 
 mkfs: mkfs.c fs.h
diff -ruN -x .git a/proc.c b/proc.c
--- a/proc.c	2026-01-31 13:48:34.362722863 -0500
+++ b/proc.c	2026-01-31 13:49:26.308894900 -0500
@@ -112,6 +112,9 @@
   memset(p->context, 0, sizeof *p->context);
   p->context->eip = (uint)forkret;
 
+  p->is_thread = 0;
+  p->stack = 0;
+
   return p;
 }
 
@@ -159,8 +162,10 @@
 growproc(int n)
 {
   uint sz;
-  struct proc *curproc = myproc();
+  struct proc *curproc;
+  struct proc *p;
 
+  curproc = myproc();
   sz = curproc->sz;
   if(n > 0){
     if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
@@ -169,7 +174,12 @@
     if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
       return -1;
   }
-  curproc->sz = sz;
+  acquire(&ptable.lock);
+  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
+    if(p->pgdir == curproc->pgdir)
+      p->sz = sz;
+  }
+  release(&ptable.lock);
   switchuvm(curproc);
   return 0;
 }
@@ -198,6 +208,8 @@
   }
   np->sz = curproc->sz;
   np->parent = curproc;
+  np->is_thread = 0;
+  np->stack = 0;
   *np->tf = *curproc->tf;
 
   // Clear %eax so that fork returns 0 in the child.
@@ -221,6 +233,61 @@
   return pid;
 }
 
+int
+clone(void (*fcn)(void *, void *), void *arg1, void *arg2, void *stack)
+{
+  int i, pid;
+  struct proc *np;
+  struct proc *curproc = myproc();
+  uint sp;
+
+  if(stack == 0)
+    return -1;
+  if((uint)stack % PGSIZE != 0)
+    return -1;
+  if((uint)stack >= curproc->sz || (uint)stack + PGSIZE > curproc->sz)
+    return -1;
+  if((uint)fcn >= curproc->sz)
+    return -1;
+
+  if((np = allocproc()) == 0)
+    return -1;
+
+  np->pgdir = curproc->pgdir;
+  np->sz = curproc->sz;
+  np->parent = curproc;
+  np->is_thread = 1;
+  np->stack = stack;
+
+  *np->tf = *curproc->tf;
+  np->tf->eax = 0;
+
+  sp = (uint)stack + PGSIZE;
+  sp -= 4;
+  *(uint*)sp = (uint)arg2;
+  sp -= 4;
+  *(uint*)sp = (uint)arg1;
+  sp -= 4;
+  *(uint*)sp = 0xffffffff;
+  np->tf->esp = sp;
+  np->tf->eip = (uint)fcn;
+
+  for(i = 0; i < NOFILE; i++)
+    if(curproc->ofile[i])
+      np->ofile[i] = filedup(curproc->ofile[i]);
+  np->cwd = idup(curproc->cwd);
+
+  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
+
+  pid = np->pid;
+
+  acquire(&ptable.lock);
+  np->state = RUNNABLE;
+  release(&ptable.lock);
+
+  return pid;
+}
+
 // Exit the current process.  Does not return.
 // An exited process remains in the zombie state
 // until its parent calls wait() to find out it exited.
@@ -283,6 +350,8 @@
     for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
       if(p->parent != curproc)
         continue;
+      if(p->is_thread)
+        continue;
       havekids = 1;
       if(p->state == ZOMBIE){
         // Found one.
@@ -294,6 +363,8 @@
         p->parent = 0;
         p->name[0] = 0;
         p->killed = 0;
+        p->is_thread = 0;
+        p->stack = 0;
         p->state = UNUSED;
         release(&ptable.lock);
         return pid;
@@ -311,6 +382,51 @@
   }
 }
 
+int
+join(void **stack)
+{
+  struct proc *p;
+  int havekids, pid;
+  struct proc *curproc = myproc();
+
+  acquire(&ptable.lock);
+  for(;;){
+    havekids = 0;
+    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
+      if(p->parent != curproc)
+        continue;
+      if(!p->is_thread)
+        continue;
+      havekids = 1;
+      if(p->state == ZOMBIE){
+        pid = p->pid;
+        if(copyout(curproc->pgdir, (uint)stack, (char *)&p->stack, sizeof(void *)) < 0){
+          release(&ptable.lock);
+          return -1;
+        }
+        kfree(p->kstack);
+        p->kstack = 0;
+        p->pid = 0;
+        p->parent = 0;
+        p->name[0] = 0;
+        p->killed = 0;
+        p->is_thread = 0;
+        p->stack = 0;
+        p->state = UNUSED;
+        release(&ptable.lock);
+        return pid;
+      }
+    }
+
+    if(!havekids || curproc->killed){
+      release(&ptable.lock);
+      return -1;
+    }
+
+    sleep(curproc, &ptable.lock);
+  }
+}
+
 //PAGEBREAK: 42
 // Per-CPU process scheduler.
 // Each CPU calls scheduler() after setting itself up.
diff -ruN -x .git a/proc.h b/proc.h
--- a/proc.h	2026-01-31 13:48:34.362722863 -0500
+++ b/proc.h	2026-01-31 13:48:52.900784835 -0500
@@ -49,6 +49,8 @@
   struct file *ofile[NOFILE];  // Open files
   struct inode *cwd;           // Current directory
   char name[16];               // Process name (debugging)
+  int is_thread;
+  void *stack;
 };
 
 // Process memory is laid out contiguously, low addresses first:
diff -ruN -x .git a/syscall.c b/syscall.c
--- a/syscall.c	2026-01-31 13:48:34.363722866 -0500
+++ b/syscall.c	2026-01-31 13:49:37.323930753 -0500
@@ -84,6 +84,7 @@
 
 extern int sys_chdir(void);
 extern int sys_close(void);
+extern int sys_clone(void);
 extern int sys_dup(void);
 extern int sys_exec(void);
 extern int sys_exit(void);
@@ -91,6 +92,7 @@
 extern int sys_fstat(void);
 extern int sys_getpid(void);
 extern int sys_kill(void);
+extern int sys_join(void);
 extern int sys_link(void);
 extern int sys_mkdir(void);
 extern int sys_mknod(void);
@@ -126,6 +128,8 @@
 [SYS_link]    sys_link,
 [SYS_mkdir]   sys_mkdir,
 [SYS_close]   sys_close,
+[SYS_clone]   sys_clone,
+[SYS_join]    sys_join,
 };
 
 void
diff -ruN -x .git a/syscall.h b/syscall.h
--- a/syscall.h	2026-01-31 13:48:34.363722866 -0500
+++ b/syscall.h	2026-01-31 13:49:30.355908097 -0500
@@ -20,3 +20,5 @@
 #define SYS_link   19
 #define SYS_mkdir  20
 #define SYS_close  21
+#define SYS_clone  22
+#define SYS_join   23
diff -ruN -x .git a/sysproc.c b/sysproc.c
--- a/sysproc.c	2026-01-31 13:48:34.363722866 -0500
+++ b/sysproc.c	2026-01-31 13:49:44.599954320 -0500
@@ -27,6 +27,36 @@
 }
 
 int
+sys_clone(void)
+{
+  int fcn;
+  int arg1;
+  int arg2;
+  int stack;
+
+  if(argint(0, &fcn) < 0)
+    return -1;
+  if(argint(1, &arg1) < 0)
+    return -1;
+  if(argint(2, &arg2) < 0)
+    return -1;
+  if(argint(3, &stack) < 0)
+    return -1;
+
+  return clone((void (*)(void *, void *))fcn, (void *)arg1, (void *)arg2, (void *)stack);
+}
+
+int
+sys_join(void)
+{
+  char *stack;
+
+  if(argptr(0, &stack, sizeof(void *)) < 0)
+    return -1;
+  return join((void **)stack);
+}
+
+int
 sys_kill(void)
 {
   int pid;
diff -ruN -x .git a/ulib.c b/ulib.c
--- a/ulib.c	2026-01-31 13:48:34.363722866 -0500
+++ b/ulib.c	2026-01-31 13:50:14.504050251 -0500
@@ -104,3 +104,72 @@
     *dst++ = *src++;
   return vdst;
 }
+
+static inline uint
+fetch_and_add(volatile uint *addr, uint val)
+{
+  asm volatile("lock; xaddl %0, %1" : "+r" (val), "+m" (*addr) : : "cc");
+  return val;
+}
+
+int
+thread_create(void (*start_routine)(void *, void *), void *arg1, void *arg2)
+{
+  void *stack;
+  uint sp;
+  int pid;
+
+  stack = malloc(PGSIZE * 2);
+  if(stack == 0)
+    return -1;
+
+  sp = (uint)stack;
+  sp = (sp + PGSIZE - 1) & ~(PGSIZE - 1);
+  if(sp == (uint)stack)
+    sp += PGSIZE;
+
+  *(void **)(sp - sizeof(void *)) = stack;
+
+  pid = clone(start_routine, arg1, arg2, (void *)sp);
+  if(pid < 0){
+    free(stack);
+    return -1;
+  }
+  return pid;
+}
+
+int
+thread_join(void)
+{
+  void *stack;
+  int pid;
+
+  stack = 0;
+  pid = join(&stack);
+  if(pid < 0)
+    return -1;
+  if(stack)
+    free(*(void **)((uint)stack - sizeof(void *)));
+  return pid;
+}
+
+void
+lock_init(lock_t *lock)
+{
+  lock->ticket = 0;
+  lock->turn = 0;
+}
+
+void
+lock_acquire(lock_t *lock)
+{
+  uint ticket = fetch_and_add(&lock->ticket, 1);
+  while(lock->turn != ticket)
+    ;
+}
+
+void
+lock_release(lock_t *lock)
+{
+  fetch_and_add(&lock->turn, 1);
+}
diff -ruN -x .git a/user.h b/user.h
--- a/user.h	2026-01-31 13:48:34.363722866 -0500
+++ b/user.h	2026-01-31 13:50:02.812012919 -0500
@@ -1,6 +1,12 @@
+#include "mmu.h"
 struct stat;
 struct rtcdate;
 
+typedef struct {
+  volatile uint ticket;
+  volatile uint turn;
+} lock_t;
+
 // system calls
 int fork(void);
 int exit(void) __attribute__((noreturn));
@@ -23,6 +29,8 @@
 char* sbrk(int);
 int sleep(int);
 int uptime(void);
+int clone(void (*)(void *, void *), void *, void *, void *);
+int join(void **);
 
 // ulib.c
 int stat(const char*, struct stat*);
@@ -37,3 +45,8 @@
 void* malloc(uint);
 void free(void*);
 int atoi(const char*);
+int thread_create(void (*)(void *, void *), void *, void *);
+int thread_join(void);
+void lock_init(lock_t *);
+void lock_acquire(lock_t *);
+void lock_release(lock_t *);
diff -ruN -x .git a/usys.S b/usys.S
--- a/usys.S	2026-01-31 13:48:34.363722866 -0500
+++ b/usys.S	2026-01-31 13:50:18.687063553 -0500
@@ -29,3 +29,5 @@
 SYSCALL(sbrk)
 SYSCALL(sleep)
 SYSCALL(uptime)
+SYSCALL(clone)
+SYSCALL(join)
PATCH
