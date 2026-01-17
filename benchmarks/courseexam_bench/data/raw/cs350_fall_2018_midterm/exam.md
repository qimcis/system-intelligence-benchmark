# CS350 Fall 2018 Midterm

```json
{
  "exam_id": "cs350_fall_2018_midterm",
  "test_paper_name": "CS350 Fall 2018 Midterm",
  "course": "CS 350",
  "institution": "University of Waterloo",
  "year": 2018,
  "score_total": 57,
  "num_questions": 23
}
```

---

## Question 1 [15 point(s)]

### a. (2 marks)
Is it possible to have more than one switchframe in a kernel stack?  Explain why or why not.

```json
{
  "problem_id": "1a",
  "points": 2,
  "type": "Freeform",
  "tags": ["kernel-stack"],
  "answer": "No. A running thread stores a switchframe in its kernel stack as it context switches to a different thread. Upon returning to the thread, the switchframe is popped off the thread’s kernel stack. Since it is not possible for a thread to context switch away twice without context switching back once in between, there can only be one switchframe in a kernel stack.",
  "llm_judge_instructions": "Award 2 points for stating that only one switchframe can be present; 0 points otherwise."
}
```

### b. (3 marks)
Explain  why  the  following  implementation  of  semaphore  P  is  incorrect.   Provide  an  example interaction between two threads that illustrates the problem.
```c
void P(struct semaphore* sem) {
  spinlock_acquire(&sem->sem_lock);
  while (sem->sem_count == 0) {
    spinlock_release(&sem->sem_lock);
    wchan_lock(sem->sem_wchan);
    wchan_sleep(sem->sem_wchan);
    spinlock_acquire(&sem->sem_lock);
  }
  sem->sem_count--;
  spinlock_release(&sem->sem_lock);
}
```

```json
{
  "problem_id": "1b",
  "points": 3,
  "type": "Freeform",
  "tags": ["semaphores"],
  "answer": "Because there is a window between spinlock_release and wchan_lock where no locks are held, allowing another thread to modify the semaphore state.",
  "llm_judge_instructions": "Award 3 points for identifying the window where no locks are held and that another thread can modify the semaphore state; 0 points otherwise."
}
```

### c. (2 marks)
Explain why system calls need to increment the EPC by 4 before returning to user space.  Why is incrementing the EPC not necessary when handling other exceptions?

```json
{
  "problem_id": "1c",
  "points": 2,
  "type": "Freeform",
  "tags": ["system-calls","exceptions"],
  "answer": "syscall is an instruction, and so returning to the PC of the system call will cause another syscall exception to be raised. With other exceptions, the exceptional circumstance should be resolved, and the command itself rerun.",
  "llm_judge_instructions": "Award 2 points for noting that the EPC must advance to avoid re-triggering the system call; 0 points otherwise."
}
```

### d. (2 marks)
Explain why a page table entry does not contain a page number, yet a TLB entry contains both a page number and a frame number.

```json
{
  "problem_id": "1d",
  "points": 2,
  "type": "Freeform",
  "tags": ["virtual-memory","tlb"],
  "answer": "The page number is the index into the page table and would be redundant to store in a PTE. The TLB is a cache of mappings and must indicate which entries are cached, so it stores both the page number and frame number.",
  "llm_judge_instructions": "Award 2 points for stating redundancy of page number in a PTE and the purpose of the TLB as a cache storing the page number and frame number; 0 points otherwise."
}
```

### e. (2 marks)
A trapframe contains more information than a switchframe.  Why?

```json
{
  "problem_id": "1e",
  "points": 2,
  "type": "Freeform",
  "tags": ["trapframe","switchframe"],
  "answer": "switchframe is a function with typical calling conventions; an exception is not called, but raised unexpectedly, so all caller-saved state must be preserved, hence trapframes contain more information.",
  "llm_judge_instructions": "Award 2 points for noting that trapframes must save more state due to asynchronous exceptions, while switchframes follow function-call conventions; 0 points otherwise."
}
```

### f. (4 marks)
Imagine a version of OS/161 with the following bug:  When the exception caused by division by zero is raised, the kernel instead handles it as a system call.  What will be the behavior of the following program if the compiler stores n in v0 and d in a0?  What will be the behavior if the compiler stores n in a0 and d in v0?

Table of system calls:
System CallSystem Call #
pidt fork(void)0
pidt vfork(void)1
int execv(const char *program, char **args)2
void exit(int exitcode)3
pidt waitpid(pidt, int *status, int options)4
pidt getpid(void)5

int main() {
int n = 6;
int d;
for (d = 2; d >= 0; d--)
n /= d;
printf("%d\n", d);
return 0;
}

```json
{
  "problem_id": "1f",
  "points": 4,
  "type": "Freeform",
  "tags": ["exceptions","syscalls","division-by-zero"],
  "answer": "First case: The program will exit with exit code 0. Second case: The program will spawn children in a (slow) loop, with each child printing -1.",
  "llm_judge_instructions": "Award 4 points for identifying the two scenarios: (1) exit code 0, (2) multiple children each printing -1; 0 points otherwise."
}
```

---

## Question 2 [8 point(s)]

Consider the following functions:
```c
int a, b;
struct lock* lock_a;
struct lock* lock_b;
struct cv* cv;
void funcAB() {
  lock_acquire(lock_b);
  // Code that reads/writes b
  lock_acquire(lock_a);
  // Code that reads/writes a
  while (b > 0) {
    cv_wait(cv, lock_b);
  }
  // More code that reads/writes b
  lock_release(lock_a);
  lock_release(lock_b);
}
void funcA() {
  lock_acquire(lock_a);
  // Code that reads/writes a
  lock_release(lock_a);
}
void funcB() {
  lock_acquire(lock_b);
  b = 0;
  cv_signal(cv, lock_b);
  lock_release(lock_b);
}
```
In this program, multiple threads concurrently call each of these functions.  No other functions acquire
or releaselockaandlockb, and a thread will only access the global variablesaandbif they are
holdinglockaandlockbrespectively.  You can assume the locks and condition variable have been
created successfully.  The global variables in this program do not have to be declared as volatile.

### a. (2 marks)
What concurrency problem does this program suffer from?

```json
{
  "problem_id": "2a",
  "points": 2,
  "type": "Freeform",
  "tags": ["deadlock"],
  "answer": "Deadlock",
  "llm_judge_instructions": "Award 2 points for stating 'Deadlock'; 0 points otherwise."
}
```

### b. (4 marks)
Provide a sequence of events that can trigger this problem.

```json
{
  "problem_id": "2b",
  "points": 4,
  "type": "Freeform",
  "tags": ["deadlock","synchronization"],
  "answer": "Thread 1 calls funcAB and goes to sleep in cvwait. Thread 2 calls funcB. Thread 3 calls funcAB and sleeps waiting for lock A, after acquiring lock B. Thread 1 awakes and attempts to take lock B.",
  "llm_judge_instructions": "Award 4 points for the described interleaving leading to deadlock; 0 otherwise."
}
```

### c. (2 marks)
What changes to any of the above functions would address this problem?

```json
{
  "problem_id": "2c",
  "points": 2,
  "type": "Freeform",
  "tags": ["deadlock","synchronization"],
  "answer": "Acquire lock A before lock B in funcAB.",
  "llm_judge_instructions": "Award 2 points for proposing locking order change (A before B); 0 otherwise."
}
```

---

## Question 3 [10 total marks]

You are designing a paged virtual memory system on a system with 32-bit virtual addresses and 48-bit
physical addresses.  Each page is 4KB (2^12 bytes), and each page table entry is 64 bits (8 bytes, 2^3 bytes).

### a. (2 marks)
In  a  single-level  paged  system,  how  many  bits  of  a  virtual memory  address  would  refer  to  the
page number and how many to the offset?  How many bits of a physical address would refer to
the frame number and how many to the offset?

```json
{
  "problem_id": "3a",
  "points": 2,
  "type": "Freeform",
  "tags": ["virtual-memory","single-level-page-table"],
  "answer": "20, 12, 36, 12",
  "llm_judge_instructions": "Award 2 points for enumerating: VPN=20, offset=12; PFN=36, offset=12; 0 otherwise."
}
```

### b. (2 marks)
How many bytes would a single-level page table require?

```json
{
  "problem_id": "3b",
  "points": 2,
  "type": "Freeform",
  "tags": ["virtual-memory","single-level-page-table"],
  "answer": "2^23 (8,388,608) bytes",
  "llm_judge_instructions": "Award 2 points for 8,388,608 bytes; 0 otherwise."
}
```

### c. (2 marks)
If a page table entry contains a frame number, a valid bit, a writeable bit, and a single bit for
tracking page useage, how many bits per page table entry are unused?

```json
{
  "problem_id": "3c",
  "points": 2,
  "type": "Freeform",
  "tags": ["virtual-memory","pte"],
  "answer": "25",
  "llm_judge_instructions": "Award 2 points for 25; 0 otherwise."
}
```

### d. (2 marks)
How many page table entries fit onto a single page?

```json
{
  "problem_id": "3d",
  "points": 2,
  "type": "Freeform",
  "tags": ["virtual-memory","pte"],
  "answer": "512",
  "llm_judge_instructions": "Award 2 points for 512; 0 otherwise."
}
```

### e. (2 marks)
What is the minimum number of levels necessary to implement a multi-level paged system if each
page table at each level must fit into a single page?

```json
{
  "problem_id": "3e",
  "points": 2,
  "type": "Freeform",
  "tags": ["virtual-memory","multilevel-paging"],
  "answer": "3",
  "llm_judge_instructions": "Award 2 points for 3; 0 otherwise."
}
```

---

## Question 4 [8 total marks]

Many operating systems implement a system call vfork, which is similar to fork, but with these two
changes:
1.  The  child  process  shares  the  parent  process  ’s  address  space.   That  is,  the  address  space  is not
copied, it is shared.
2.  Upon calling vfork, the parent process blocks until the child process has called execv.

### a. (3 marks)
Change the following sketch of an implementation of fork to instead implement vfork.  Assume
that the appropriate changes are made to execv elsewhere.  You may cross out steps and add new
steps.
```text
sys_fork() {
  create process structure
  copy address space
  choose pid for new process
  create parent/child relationship
  duplicate trapframe
  create thread for new process (running child_process)
}
child_process() {
  copy trapframe to stack
  modify trapframe
  enter usermode
}
```
Modify the implementation to link to the same address space instead of copying, and ensure the parent blocks until the child reaches execv.

```json
{
  "problem_id": "4a",
  "points": 3,
  "type": "Freeform",
  "tags": ["vfork","execv"],
  "answer": "Replace 'copy address space' with 'link to same address space', and add 'block until child has reached execv'.",
  "llm_judge_instructions": "Award 3 points for describing the replacement and the new synchronization step; 0 otherwise."
}
```

### b. (3 marks)
Each change in the semantics of vfork impacts the implementation of execv.   How  would  an
implementation of execv need to differ to support both of these changes in vfork?

```json
{
  "problem_id": "4b",
  "points": 3,
  "type": "Freeform",
  "tags": ["vfork","execv"],
  "answer": "If process was created with vfork, do not destroy the address space.  Signal the parent.",
  "llm_judge_instructions": "Award 3 points for stating not destroying the address space and signaling the parent; 0 otherwise."
}
```

### c. (2 marks)
The  documentation  for vfork states  that  the  child  process  shouldn’t  return  from  the  function
that called vfork.  Why not?

```json
{
  "problem_id": "4c",
  "points": 2,
  "type": "Freeform",
  "tags": ["vfork","stack"],
  "answer": "The userspace stack is shared, so if the stackframe is popped, the behavior of the function when the parent returns is unpredictable.",
  "llm_judge_instructions": "Award 2 points for referencing shared user stack and unpredictable behavior; 0 otherwise."
}
```

---

## Question 5 [16 total marks]

You have been hired by the city of Waterloo to help solve a modified version of the “traffic intersection”
problem for an intersection with significant pedestrian traffic.  For safety, instead of allowing vehicles to
share the intersection with pedestrians, you are to build a scramble intersection that, under specific
conditions, stops vehicular traffic from all directions to allow pedestrians to cross the intersection.
In  this  problem,  pedestrians  and  vehicles  must  never  be  inside  the  intersection  at  the  same  time.
Vehicles  must  also  not  collide  with  other  vehicles.   When  a pedestrian  arrives  at the  intersection,
he/she  must  wait  until  the intersection  is clear  of  vehicles  before  entering.   However,  no  additional
vehicles  must  be  allowed  to  enter the intersection  while  a pedestrian  is  either  waiting  or  inside the
intersection.

The intersection consists of two one-way roads:  one north-to-south and the other east-to-west.  Each
vehicle arrives at the intersection from one of two directions (north or east), called its origin.  It is trying
to pass through the intersection and exit in the opposite direction of its origin, called its destination.
Turns for vehicles are not allowed.  Because pedestrians cannot collide with other pedestrians and
can only cross when there are no vehicles inside the intersection, we do not need to know a pedestrian’s
origin or destination.

Implement the following six functions.  Global variables can be defined in the provided space.  Your
solution should be efficient.   It should  also  prioritize  pedestrians  while  providing  fairness  between
vehicles.

The six functions to implement:
- intersection_sync_init(void)
- intersection_sync_cleanup(void)
- intersection_before_vehicle_entry(Direction origin)
- intersection_after_vehicle_exit(Direction origin)
- intersection_before_pedestrian_entry(void)
- intersection_after_pedestrian_exit(void)

(Do NOT include solutions or sample implementations here; implement the functions as part of your answer.)

### a. (3 marks)
Implement intersection_sync_init(void): initialize locks, condition variables and counters necessary for the synchronization behavior described.

```json
{
  "problem_id": "5a",
  "points": 3,
  "type": "Freeform",
  "tags": ["traffic-intersection","pedestrians","synchronization"],
  "answer": "Implement intersection_sync_init as shown (initialize lk, per-direction car counters, dir_cv, ped_cv, ped_inside, ped_waiting, next_after_ped).",
  "llm_judge_instructions": "Award 3 points for providing correct initialization of synchronization primitives and state variables as in the code; 0 otherwise."
}
```

### b. (3 marks)
Implement intersection_sync_cleanup(void): clean up any synchronization primitives allocated in init and ensure no outstanding waiters remain.

```json
{
  "problem_id": "5b",
  "points": 3,
  "type": "Freeform",
  "tags": ["traffic-intersection","cleanup"],
  "answer": "Destroy all condition variables and locks allocated during init; ensure no outstanding waiters.",
  "llm_judge_instructions": "Award 3 points for describing proper cleanup of synchronization primitives; 0 otherwise."
}
```

### c. (3 marks)
Implement intersection_before_vehicle_entry(Direction origin): ensure vehicles follow the rules (no pedestrians inside or waiting; prevent collisions; provide fairness as described).

```json
{
  "problem_id": "5c",
  "points": 3,
  "type": "Freeform",
  "tags": ["traffic-intersection","vehicles"],
  "answer": "Provide an implementation for intersection_before_vehicle_entry that waits when pedestrians are present or waiting, and respects car presence from opposing direction.",
  "llm_judge_instructions": "Award 3 points for a correct approach that enforces pedestrian priority and fairness constraints in vehicle entry."
}
```

### d. (3 marks)
Implement intersection_after_vehicle_exit(Direction origin): handle wake-ups for pedestrians or opposing vehicles and update any needed state to preserve fairness and pedestrian priority.

```json
{
  "problem_id": "5d",
  "points": 3,
  "type": "Freeform",
  "tags": ["traffic-intersection","vehicles","exit"],
  "answer": "Implement vehicle exit handling: if no more cars in this direction, wake pedestrians if waiting; otherwise wake up opposing vehicle direction and update next_after_ped.",
  "llm_judge_instructions": "Award 3 points for a correct explanation of wakeup behavior after a vehicle exits, including interaction with ped_waiting and next_after_ped."
}
```

### e. (2 marks)
Implement intersection_before_pedestrian_entry(void): pedestrians must wait until intersection is empty; mark ped_inside appropriately.

```json
{
  "problem_id": "5e",
  "points": 2,
  "type": "Freeform",
  "tags": ["traffic-intersection","pedestrians"],
  "answer": "Pedestrian waits until there are no vehicles inside the intersection; then enters and marks ped_inside.",
  "llm_judge_instructions": "Award 2 points for correct behavior: pedestrians wait for empty intersection, then enter."
}
```

### f. (2 marks)
Implement intersection_after_pedestrian_exit(void): on last pedestrian exit, wake up vehicles according to fairness policy and next_after_ped.

```json
{
  "problem_id": "5f",
  "points": 2,
  "type": "Freeform",
  "tags": ["traffic-intersection","pedestrians"],
  "answer": "After pedestrian exits, wake up waiting cars if any in next_after_ped; otherwise wake up opposing direction and keep next_after_ped unchanged or updated accordingly.",
  "llm_judge_instructions": "Award 2 points for a correct explanation of wakeup logic after pedestrians exit."
}
```

---

## Question 6 [8 total marks]

### a. (3 marks)
Change the following sketch of an implementation of fork to instead implement vfork.  Assume
that the appropriate changes are made to execv elsewhere.  You may cross out steps and add new
steps.
```text
sys_fork() {
  create process structure
  copy address space
  choose pid for new process
  create parent/child relationship
  duplicate trapframe
  create thread for new process (running child_process)
}
child_process() {
  copy trapframe to stack
  modify trapframe
  enter usermode
}
```

```json
{
  "problem_id": "6a",
  "points": 3,
  "type": "Freeform",
  "tags": ["vfork","execv"],
  "answer": "Replace 'copy address space' with 'link to same address space', and add 'block until child has reached execv'.",
  "llm_judge_instructions": "Award 3 points for describing the replacement and the new synchronization step; 0 otherwise."
}
```

### b. (3 marks)
Each change in the semantics of vfork impacts the implementation of execv.   How  would  an
implementation of execv need to differ to support both of these changes in vfork?

```json
{
  "problem_id": "6b",
  "points": 3,
  "type": "Freeform",
  "tags": ["vfork","execv"],
  "answer": "If process was created with vfork, do not destroy the address space.  Signal the parent.",
  "llm_judge_instructions": "Award 3 points for stating not destroying the address space and signaling the parent; 0 otherwise."
}
```

### c. (2 marks)
The  documentation  for vfork states  that  the  child  process  shouldn’t  return  from  the  function
that called vfork.  Why not?

```json
{
  "problem_id": "6c",
  "points": 2,
  "type": "Freeform",
  "tags": ["vfork","stack"],
  "answer": "The userspace stack is shared, so if the stackframe is popped, the behavior of the function when the parent returns is unpredictable.",
  "llm_judge_instructions": "Award 2 points for referencing shared user stack and unpredictable behavior; 0 otherwise."
}
```

---

## Question 7 [16 total marks]

(Implementation-style question; answer should implement the synchronization behavior for the scramble intersection described in Question 5. Provide code or detailed pseudocode implementing the six functions and any global state used. Do not include instructor solutions in the question prompt.)

### a. (3 marks)
Implement intersection_sync_init as required for the problem.

```json
{
  "problem_id": "7a",
  "points": 3,
  "type": "Freeform",
  "tags": ["traffic-intersection","pedestrians","synchronization"],
  "answer": "Implement intersection_sync_init as shown (initialize lk, per-direction car counters, dir_cv, ped_cv, ped_inside, ped_waiting, next_after_ped).",
  "llm_judge_instructions": "Award 3 points for providing correct initialization of synchronization primitives and state variables as in the code; 0 otherwise."
}
```

### b. (3 marks)
Implement intersection_sync_cleanup to properly destroy synchronization primitives allocated during init and ensure no outstanding waiters.

```json
{
  "problem_id": "7b",
  "points": 3,
  "type": "Freeform",
  "tags": ["traffic-intersection","cleanup"],
  "answer": "Destroy all condition variables and locks allocated during init; ensure no outstanding waiters.",
  "llm_judge_instructions": "Award 3 points for describing proper cleanup of synchronization primitives; 0 otherwise."
}
```

### c. (3 marks)
Implement intersection_before_vehicle_entry(Direction origin) to enforce pedestrian priority and fairness between vehicle directions.

```json
{
  "problem_id": "7c",
  "points": 3,
  "type": "Freeform",
  "tags": ["traffic-intersection","vehicles"],
  "answer": "Provide an implementation for intersection_before_vehicle_entry that waits when pedestrians are present or waiting, and respects car presence from opposing direction.",
  "llm_judge_instructions": "Award 3 points for a correct approach that enforces pedestrian priority and fairness constraints in vehicle entry."
}
```

### d. (3 marks)
Implement intersection_after_vehicle_exit(Direction origin) to wake pedestrians or vehicles as appropriate and update fairness state.

```json
{
  "problem_id": "7d",
  "points": 3,
  "type": "Freeform",
  "tags": ["traffic-intersection","vehicles","exit"],
  "answer": "Implement vehicle exit handling: if no more cars in this direction, wake pedestrians if waiting; otherwise wake up opposing vehicle direction and update next_after_ped.",
  "llm_judge_instructions": "Award 3 points for a correct explanation of wakeup behavior after a vehicle exits, including interaction with ped_waiting and next_after_ped."
}
```

### e. (2 marks)
Implement intersection_before_pedestrian_entry so pedestrians wait until intersection is empty and mark ped_inside appropriately.

```json
{
  "problem_id": "7e",
  "points": 2,
  "type": "Freeform",
  "tags": ["traffic-intersection","pedestrians"],
  "answer": "Pedestrian waits until there are no vehicles inside the intersection; then enters and marks ped_inside.",
  "llm_judge_instructions": "Award 2 points for correct behavior: pedestrians wait for empty intersection, then enter."
}
```

### f. (2 marks)
Implement intersection_after_pedestrian_exit to wake waiting vehicles according to the fairness policy.

```json
{
  "problem_id": "7f",
  "points": 2,
  "type": "Freeform",
  "tags": ["traffic-intersection","pedestrians"],
  "answer": "After pedestrian exits, wake up waiting cars if any in next_after_ped; otherwise wake up opposing direction and keep next_after_ped unchanged or updated accordingly.",
  "llm_judge_instructions": "Award 2 points for a correct explanation of wakeup logic after pedestrians exit."
}
```

---