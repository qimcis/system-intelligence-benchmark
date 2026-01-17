# COMP 350 Fall 2018 Midterm

```json
{
  "exam_id": "comp_350_fall_2018_midterm",
  "test_paper_name": "COMP 350 Fall 2018 Midterm",
  "course": "COMP 350",
  "institution": "University of Waterloo",
  "year": 2018,
  "score_total": 75,
  "num_questions": 7
}
```

---

## Question 1 [15 point(s)]

1. (15 total marks)

a. (2 marks)  
Is it possible to have more than one switchframe in a kernel stack? Explain why or why not.

b. (3 marks)  
Explain why the following implementation of semaphore P is incorrect. Provide an example interaction between two threads that illustrates the problem.

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

c. (2 marks)  
Explain why system calls need to increment the EPC by 4 before returning to user space. Why is incrementing the EPC not necessary when handling other exceptions?

d. (2 marks)  
Explain why a page table entry does not contain a page number, yet a TLB entry contains both a page number and a frame number.

e. (2 marks)  
A trapframe contains more information than a switchframe. Why?

f. (4 marks)  
Imagine a version of OS/161 with the following bug: When the exception caused by division by zero is raised, the kernel instead handles it as a system call. What will be the behavior of the following program if the compiler stores n in v0 and d in a0? What will be the behavior if the compiler stores n in a0 and d in v0?

Table of system calls:
System Call | System Call #
fork(void) | 0
vfork(void) | 1
int execv(const char *program, char **args) | 2
void exit(int exitcode) | 3
pid_t waitpid(pid_t, int *status, int options) | 4
pid_t getpid(void) | 5

int main() {
  int n = 6;
  int d;
  for (d = 2; d >= 0; d--)
    n /= d;
  printf("%d\n", d);
  return 0;
}

---

## Question 2 [8 total marks]

a. (2 marks)  
What concurrency problem does this program suffer from?

b. (4 marks)  
Provide a sequence of events that can trigger this problem.

c. (2 marks)  
What changes to any of the above functions would address this problem?

---

## Question 3 [10 total marks]

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

## Question 4 [10 marks]

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

Consider the following code:

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

Draw the tree of processes created, with the value printed for res in each node of the tree, and the vertices pointing from parents to children.

---

## Question 6 [8 total marks]

Many operating systems implement a system call vfork, which is similar to fork, but with these two changes:
1. The child process shares the parent process's address space. That is, the address space is not copied; it is shared.
2. Upon calling vfork, the parent process blocks until the child process has called execv.

a. (3 marks)  
Change the following sketch of an implementation of fork to instead implement vfork. Assume that the appropriate changes are made to execv elsewhere. You may cross out steps and add new steps.

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

b. (3 marks)  
Each change in the semantics of vfork impacts the implementation of execv. How would an implementation of execv need to differ to support both of these changes in vfork?

c. (2 marks)  
The documentation for vfork states that the child process shouldn’t return from the function that called vfork. Why not?

---

## Question 7 [16 total marks]

You have been hired by the city of Waterloo to help solve a modified version of the “traffic intersection” problem for an intersection with significant pedestrian traffic. For safety, instead of allowing vehicles to share the intersection with pedestrians, you are to build a scramble intersection that, under specific conditions, stops vehicular traffic from all directions to allow pedestrians to cross the intersection.

In this problem, pedestrians and vehicles must never be inside the intersection at the same time. Vehicles must also not collide with other vehicles. When a pedestrian arrives at the intersection, he/she must wait until the intersection is clear of vehicles before entering. However, no additional vehicles must be allowed to enter the intersection while a pedestrian is either waiting or inside the intersection.

The intersection consists of two one-way roads: one north-to-south and the other east-to-west. Each vehicle arrives at the intersection from one of two directions (north or east), called its origin. It is trying to pass through the intersection and exit in the opposite direction of its origin, called its destination. Turns for vehicles are not allowed. Because pedestrians cannot collide with other pedestrians and can only cross when there are no vehicles inside the intersection, we do not need to know a pedestrian’s origin or destination.

Implement the following six functions. Global variables can be defined in the provided space. Your solution should be efficient. It should also prioritize pedestrians while providing fairness between vehicles.

- Define any global variables you need in the space indicated.
- Implement these functions:
  - void intersection_sync_init(void);
  - void intersection_sync_cleanup(void);
  - void intersection_before_vehicle_entry(Direction origin);
  - void intersection_after_vehicle_exit(Direction origin);
  - void intersection_before_pedestrian_entry(void);
  - void intersection_after_pedestrian_exit(void);

You may use synchronization primitives such as locks, condition variables (CVs), and any standard OS-level primitives covered in class.

Enum and helper provided for clarity:

enum Directions {
  north = 0, east = 1
};
typedef enum Directions Direction;

Direction opposing_dir(Direction d) {
  return (d == north) ? east : north;
}

Provide your implementation below (define globals and implement the six functions).