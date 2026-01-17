# CS350 Fall 2018 Midterm

```json
{
  "exam_id": "cs350_fall_2018_midterm",
  "test_paper_name": "CS350 Fall 2018 Midterm",
  "course": "CS 350",
  "institution": "University of Waterloo",
  "year": 2018,
  "score_total": 71,
  "num_questions": 7
}
```

---

## Question 1 [15 point(s)]

a. (2 marks)  
Is it possible to have more than one switchframe in a kernel stack? Explain why or why not.

b. (3 marks)  
Explain why the following implementation of semaphore P is incorrect. Provide an example interaction between two threads that illustrates the problem.

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

c. (2 marks)  
Explain why system calls need to increment the EPC by 4 before returning to user space. Why is incrementing the EPC not necessary when handling other exceptions?

d. (2 marks)  
Explain why a page table entry does not contain a page number, yet a TLB entry contains both a page number and a frame number.

e. (2 marks)  
A trapframe contains more information than a switchframe. Why?

f. (4 marks)  
Imagine a version of OS/161 with the following bug: When the exception caused by division by zero is raised, the kernel instead handles it as a system call. What will be the behavior of the following program if the compiler stores n in v0 and d in a0? What will be the behavior if the compiler stores n in a0 and d in v0?

System calls (numbered):
```
fork(void)    -> 0
vfork(void)   -> 1
execv(...)    -> 2
exit(int)     -> 3
waitpid(...)  -> 4
getpid(void)  -> 5
```

```c
int main() {
    int n = 6;
    int d;
    for (d = 2; d >= 0; d--)
        n /= d;
    printf("%d\n", d);
    return 0;
}
```

Explain both cases.

---

## Question 2 [8 point(s)]

a. (2 marks)  
What concurrency problem does this program suffer from?

b. (4 marks)  
Provide a sequence of events that can trigger this problem.

c. (2 marks)  
What changes to any of the above functions would address this problem?

---

## Question 3 [6 point(s)]

An OS/161 process P accesses a virtual memory address which has a TLB miss. During vmfault in the kernel, a timer interrupt fires and P gets preempted. Draw the relevant stack frames for P’s kernel stack (show the sequence of frames and which routines they correspond to).

---

## Question 4 [10 point(s)]

You are designing a paged virtual memory system on a system with 32-bit virtual addresses and 48-bit physical addresses. Each page is 4KB (2^12 bytes), and each page table entry is 64 bits (8 bytes, 2^3 bytes).

a. (2 marks)  
In a single-level paged system, how many bits of a virtual memory address would refer to the page number and how many to the offset? How many bits of a physical address would refer to the frame number and how many to the offset?

b. (2 marks)  
How many bytes would a single-level page table require?

c. (2 marks)  
If a page table entry contains a frame number, a valid bit, a writeable bit, and a single bit for tracking page usage, how many bits per page table entry are unused?

d. (2 marks)  
How many page table entries fit onto a single page?

e. (2 marks)  
What is the minimum number of levels necessary to implement a multi-level paged system if each page table at each level must fit into a single page?

---

## Question 5 [8 marks]

Note: This question requires drawing a process tree and the value printed by each process. The problem statement involves generating a tree and values, which is not included here to avoid diagrams.

Consider the following code:

```c
int waiter(int pid) {
    int rv, ec;
    if (pid != 0) {
        rv = waitpid(pid, &ec, 0);
        if (rv != -1 && WIFEXITED(ec)) {
            return WEXITSTATUS(ec);
        }
        return 0;
    }
    return 2;
}

int main() {
    int a, b;
    int res = 0;
    a = fork();
    b = fork();
    res += waiter(a);
    res += waiter(b);
    printf("%d\n", res);
    _exit(1);
}
```

Draw the tree of processes created, with the value printed for res in each node of the tree, and the vertices pointing from parents to children.

---

## Question 6 [8 point(s)]

Many operating systems implement a system call vfork, which is similar to fork, but with these two changes:
1. The child process shares the parent process’s address space. That is, the address space is not copied; it is shared.
2. Upon calling vfork, the parent process blocks until the child process has called execv (or otherwise completed the critical section).

a. (3 marks)  
Change the following sketch of an implementation of fork to instead implement vfork. Assume that the appropriate changes are made to execv elsewhere. You may cross out steps and add new steps.

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

Make the necessary changes to implement vfork semantics (describe clearly what you change and what additional synchronization is required).

b. (3 marks)  
Each change in the semantics of vfork impacts the implementation of execv. How would an implementation of execv need to differ to support both of these changes in vfork?

c. (2 marks)  
The documentation for vfork states that the child process shouldn’t return from the function that called vfork. Why not?

---

## Question 7 [16 point(s)]

You have been hired by the city of Waterloo to help solve a modified version of the “traffic intersection” problem for an intersection with significant pedestrian traffic. For safety, instead of allowing vehicles to share the intersection with pedestrians, you are to build a scramble intersection that, under specific conditions, stops vehicular traffic from all directions to allow pedestrians to cross the intersection.

Requirements:
- Pedestrians and vehicles must never be inside the intersection at the same time.
- Vehicles must not collide with other vehicles.
- When a pedestrian arrives at the intersection, they must wait until the intersection is clear of vehicles before entering.
- No additional vehicles may be allowed to enter the intersection while a pedestrian is either waiting or inside the intersection.
- The intersection consists of two one-way roads: one north-to-south and the other east-to-west. Each vehicle arrives from one of two directions (north or east), called its origin, and exits in the opposite direction. Turns are not allowed.
- Pedestrians do not collide with other pedestrians and do not require origin/destination.

Implement the following six synchronization functions. You may define global variables. Your solution should be efficient, prioritize pedestrians while providing fairness between vehicle directions, and avoid deadlock and starvation.

Functions to implement:
- void intersection_sync_init(void);        // Called once before starting the simulation.
- void intersection_sync_cleanup(void);     // Called once at the end of the simulation.
- void intersection_before_vehicle_entry(Direction origin);
- void intersection_after_vehicle_exit(Direction origin);
- void intersection_before_pedestrian_entry(void);
- void intersection_after_pedestrian_exit(void);

You may also define auxiliary globals, enums, and helper functions. Describe any invariants and the exact wake-up rules your solution uses, and be specific about how fairness between vehicle directions is provided while prioritizing pedestrians.