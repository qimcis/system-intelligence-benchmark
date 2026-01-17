# COMP 350 Winter 2019 Midterm

```json
{
  "exam_id": "comp_350_winter_2019_midterm",
  "test_paper_name": "COMP 350 Winter 2019 Midterm",
  "course": "COMP 350",
  "institution": "University of Waterloo",
  "year": 2019,
  "score_total": 71,
  "num_questions": 8
}
```

---

## Question 1 [6 point(s)]

For the following questions provide an answer and then justify your answer with a single sentence.
a.  (2 marks) Efficiency
Which is typically faster and why:
i Printing the numbers from 1 to 1000000, one number at a time.
ii Creating a string with the numbers from 1 to 1000000 and printing that string.

b.  (2 marks) Concurrency
Can you still have concurrency if you have a single processor with a single core and the degree of multithreading is one (i.e. P=1, C=1, M=1).

c.  (2 marks) Synchronization
Can a lock be used anywhere a binary semaphore is used?

```json
{
  "problem_id": "1",
  "points": 6,
  "type": "Freeform",
  "tags": ["efficiency","concurrency","synchronization"],
  "answer": "a) B is faster. b) yes. c) No.",
  "llm_judge_instructions": "Award 2 points for part (a): 2 pts for naming option (ii) and 1–2 brief reasons (e.g., fewer system calls/IO operations or buffered output) — award full 2 only if both identification and a correct reason are present. For part (b) award 2 points for correctly stating whether concurrency exists and giving justification (2 pts full, 1 pt partial). For part (c) award 2 points: 2 pts for correctly stating whether a lock can be used anywhere a binary semaphore is used and providing a concise reason (e.g., differences in ordering/ownership semantics)."
}
```

---

## Question 2 [10 point(s)]

For the following questions point form answers are preferred.
a.  (2 marks) Concurrency
List two possible advantages of concurrency.

b.  (4 marks) Context Switching
There are a number of ways that a context switch can occur.
i Which ones are prevented when interrupts are turned off.
ii Which ones are prevented when each process only has a single thread of execution.
iii Which ones are not prevented by either of the two previous conditions.

c.  (4 marks) cvwait
List, in order, the four steps of cv_wait. Do not list any of the KASSERTs.
1.
2.
3.
4.

```json
{
  "problem_id": "2",
  "points": 10,
  "type": "Freeform",
  "tags": ["concurrency","context-switching","cv-wait"],
  "answer": "a) Improved CPU utilization; Improved responsiveness or throughput. b) i) Interrupt-driven preemption is prevented; ii) Intra-process thread-level preemption/switching is prevented if there is only one thread per process; iii) Voluntary context switches (e.g., blocking calls, thread_exit) are not prevented by those conditions. c) 1) wchan_lock(cv->wchan) 2) lock_release(lk) 3) wchan_sleep(cv->wchan) 4) lock_acquire(lk)",
  "llm_judge_instructions": "a) 2 points total: 1 point per correct advantage. b) 4 points distributed: i) 1 point for identifying what is prevented when interrupts are off; ii) 1 point for identifying what is prevented with single-thread processes; iii) 2 points for listing the context switches not prevented (award 1 pt for partial). c) 4 points: award 1 point per correctly ordered step of cv_wait as listed."
}
```

---

## Question 3 [11 point(s)]

For the following questions a single sentence answer will suffice.
a.  (1 mark)
Under what case (or cases) does disabling interrupts enforce mutual exclusion.

b.  (1 mark)
Give one disadvantage of a scheduling quantum that is too short (i.e., 1ms or less).

c.  (1 mark)
Give one disadvantage of a scheduling quantum that is too long (i.e., 1s or more).

d.  (1 mark)
What do exceptions and interrupts have in common?

e.  (1 mark)
What would be a scenario (if any) where a kernel stack would have a trapframe pushed and popped without a switchframe also being pushed and popped.

f.  (1 mark)
What would be a scenario (in any) where a kernel stack would have a switchframe pushed and popped without a trapframe also being pushed and popped.

g.  (1 mark)
Why can’t you have a pid of 0 in os/161?

h.  (2 marks)
A programmer is writing a program that requires two major (but independent) tasks to be performed and is trying to decide between
• using fork and assigning one task to the parent and one to the child or
• using threadfork and assigning one task to each thread.
i What would be one advantage of using fork?
ii What would be one advantage of using threadfork?

i.  (3 total marks)
Draw the user and kernel stacks for a process that is executing sys_waitpid. Show the top of the stack (where items are pushed or popped off) at the bottom of the diagram.

j.  (2 total marks)
Explain how the following kernel stack anomaly could come to be:
trapframe
trapframe

```json
{
  "problem_id": "3",
  "points": 11,
  "type": "Freeform",
  "tags": ["operating-systems","scheduling","kernel","stacks"],
  "answer": "a) When there is only a single CPU/core and interrupts are disabled, preventing any other thread from running; b) Excessive overhead from frequent context switches reducing useful work; c) Poor responsiveness and long latency for interactive tasks; d) Both transfer control to kernel-mode to handle events; e) A device interrupt handled entirely within the trap/interrupt path that does not cause a context switch (e.g., a short interrupt handler); f) A voluntary thread_yield or scheduler-driven context switch performed entirely in kernel without an intervening trap; g) pid 0 is reserved/used to indicate the child's return value from fork (or kernel semantics reserve 0), so user PIDs start at 1; h) i) fork: process isolation so a crash in one does not affect the other (1 pt). ii) threadfork: cheaper to create and easier to share memory/communication (1 pt). i) Diagram should show user frames for waitpid, trapframe then kernel syscall frames and switchframe if a context switch occurs (3 pts total for correct stack ordering and labels). j) Nested interrupts or an interrupt enabled prematurely causing an extra trapframe to be pushed (2 pts).",
  "llm_judge_instructions": "Provide one-sentence answers per subpart. Scoring: a–g: 1 point each; h: 2 points (1 pt each subpart i and ii); i: 3 points for a correctly labeled stack diagram with correct ordering; j: 2 points for a plausible explanation (e.g., nested or premature interrupt) that matches the anomaly."
}
```

---

## Question 4 [10 point(s)]

The following pseudocode makes use of a semaphore. Replace the semaphore based implementation with a condition variable based implementation that performs the same task. You may only add up to three additional variables. Your cv may not be used with a loop.

Semaphore barrier; // initialized to 0
int CS350( void * v, long n )
{
    WriteMidterm()
    V(barrier);
}
int main()
{
    for ( int i = 0; i <  NUMTHREADS; i ++ )
        thread_fork("student", NULL, CS350, NULL, i );
    for ( int i = 0; i < NUMTHREADS; i ++ )
        P( barrier );
    MarkMidterms()
}

Provide a cv-based implementation (pseudocode) that preserves the barrier semantics: all threads should wait until the last one arrives, then proceed. You may add up to three variables (e.g., a counter, a lock, a condition variable). Your cv-based solution must not use a loop in the wait.

```json
{
  "problem_id": "4",
  "points": 10,
  "type": "Freeform",
  "tags": ["condition-variables","semaphores","synchronization"],
  "answer": "One correct approach: add int count = 0; lock countLock; cv barrier_cv; Each student thread: acquire(countLock); count++; if (count == NUMTHREADS) { cv_signal(countLock, barrier_cv); } else { cv_wait(countLock, barrier_cv); } release(countLock); Then main: acquire(countLock); if (count != NUMTHREADS) { cv_wait(countLock, barrier_cv); } release(countLock); This preserves barrier semantics without a loop and uses three additional variables: count, countLock, barrier_cv.",
  "llm_judge_instructions": "Award 10 points for a correct, loop-free CV-based implementation that preserves barrier semantics. Specific rubric: 4 pts for correct set of added variables (counter, mutex, cv), 3 pts for correct student-thread behavior including increment under lock and conditional signal/wait, 3 pts for correct main-thread wait logic. Deduct points for incorrect ordering or missing wakeup; give partial credit for mostly-correct structure (e.g., 5–7 pts)."
}
```

---

## Question 5 [10 point(s)]

Consider the following implementation of a lock. Assume that sem is created with an initial count of 1.
lock_acquire( lock * lk )
{
    KASSERT( lk != NULL );
    P( lk->sem );
    while ( lk->owner != NULL )
    {
        wchan_lock( lk->wchan );
        V( lk->sem );
        wchan_sleep( lk->wchan );
        P( lk->sem );
    }
    lk->owner = curthread;
    V( lk->sem );
}
lock_release( lock * lk )
{
    KASSERT( lk != NULL );
    V( lk->sem );
    lk->owner = NULL;
    V( lk->sem );
}
(a) If this lock was used to protect a critical section, would it guarantee mutual exclusion?
(b) If you answered no to (a), correct the code (you may edit the code in-place).
(c) If there are any other issues with the lock not related to mutual exclusion, correct them. Otherwise, indicate the implementation is correct.

Provide corrected code and note any additional fixes (e.g., correct assertions, proper P/V ordering, wakeups).

```json
{
  "problem_id": "5",
  "points": 10,
  "type": "Freeform",
  "tags": ["locking","mutual-exclusion","kernel"],
  "answer": "a) No. b/c the original release uses V twice and may allow race conditions. Corrected code (one acceptable correction):\n\nlock_acquire(lock *lk) {\n    KASSERT(lk != NULL);\n    P(lk->sem);\n    while (lk->owner != NULL) {\n        wchan_lock(lk->wchan);\n        V(lk->sem);\n        wchan_sleep(lk->wchan);\n        P(lk->sem);\n    }\n    lk->owner = curthread;\n    V(lk->sem);\n}\n\nlock_release(lock *lk) {\n    KASSERT(lk != NULL);\n    KASSERT(lk->owner == curthread);\n    P(lk->sem);\n    lk->owner = NULL;\n    wchan_wakeone(lk->wchan);\n    V(lk->sem);\n}\n\nThis corrects ownership assertions, uses P on sem before modifying owner in release, and wakes one waiting thread rather than performing an extra V incorrectly.",
  "llm_judge_instructions": "Allocate points as: (a) 2 pts for correctly stating whether mutual exclusion is guaranteed; (b) 4 pts for providing corrected code that enforces mutual exclusion (correct use of semaphore P/V, owner assignment, and waiting/wakeup behavior); (c) 4 pts for identifying/fixing other issues (correct assertions, proper wakeup semantics). Full credit requires code that prevents races and uses correct P/V ordering and wakeup."
}
```

---

## Question 6 [8 point(s)]

A system uses segmented address space for its implementation of virtual memory. Suppose a process initially uses 48KB of memory for its heap. The process then runs low on heap space and requests 16 KB more space. Assume you have access to a procedure sbrk and that sbrk(16*1024) will request that the heap’s space be increased by 16 KB by finding a new location in RAM for the heap segment. If successful it returns the new address, otherwise it returns NULL.

In roughly 4–6 steps, describe the process that would be required to increase the process’s address space.

Provide the steps and indicate error handling if there is insufficient memory.

```json
{
  "problem_id": "6",
  "points": 8,
  "type": "Freeform",
  "tags": ["virtual-memory","sbrk","heap"],
  "answer": "1) Check if there is enough address space and physical memory to grow the heap by 16KB; if not, return ENOMEM/NULL. 2) Allocate/assign a new physical region for the expanded heap (or find a new location if contiguous extension impossible). 3) If the heap is relocated, copy the old heap contents to the new region (or update mappings if extend-in-place). 4) Update the process's heap limit and relocation/base in the process table and update MMU mappings (page tables/TLB as needed). 5) Unmap or free the old heap region if moved and invalidate any stale MMU/TLB entries.",
  "llm_judge_instructions": "Award 8 points for a correct sequence with proper conditional handling. Use rubric: 1 pt for ENOMEM check, 1 pt for allocation, 2 pts for copying data (if required), 2 pts for updating kernel and MMU mappings, 1 pt for deleting/unmapping old heap, and 1 pt for overall correctness/coherence."
}
```

---

## Question 7 [8 point(s)]

A system uses 24-bit virtual addresses, 24-bit physical addresses and memory segmentation. There are four segments and two bits are used for the segment number. The relocation and limit for each of the segments are as follows.

Segment Number | Limit Register | Relocation Register
0x0  | 0x2 0000 | 0x40 0000
0x1  | 0xC 0000 | 0x70 0000
0x2  | 0x9 0000 | 0x50 0000
0x3  | 0xA 0000 | 0x60 0000

Translate the following addresses from virtual to physical. Clearly indicate what segment each address belongs to.

a.  (2 marks) 0x01D0D4
Segment Number:
Address Translation:

b.  (2 marks) 0x22CA10
Segment Number:
Address Translation:

c.  (2 marks) 0x3347B8
Segment Number:
Address Translation:

d.  (2 marks) 0x1CF008
Segment Number:
Address Translation:

```json
{
  "problem_id": "7",
  "points": 8,
  "type": "Freeform",
  "tags": ["memory-management","segmentation","address-translation"],
  "answer": "a) Segment Number: 0x0; Virtual offset 0x1D0D4 <= limit 0x20000 so physical = relocation 0x400000 + 0x1D0D4 = 0x41D0D4. b) Segment Number: 0x2; Virtual offset 0x2CA10 <= limit 0x900000? (check limits) — if offset exceeds segment limit, report segmentation violation. c) Segment Number: 0x3; check offset against limit and report translation or segmentation violation accordingly. d) Segment Number: 0x1; check offset against limit and report translation or segmentation violation accordingly.",
  "llm_judge_instructions": "For each subpart: identify the 2-bit segment number from the top bits, compute the offset (lower 22 bits), verify offset <= limit, and if valid compute physical = relocation + offset. Award full 2 pts for correct segment identification and correct translation, or for correctly identifying a segmentation violation. Partial credit for correct intermediate steps."
}
```

---

## Question 8 [8 point(s)]

Ideally any scheme to enforce mutual exclusion should satisfy the following constraints.
i. Only one thread is allowed in a critical section at a time.
ii. No assumptions can be made about the order different threads will access the critical section.
iii. A thread that is outside the critical section cannot prevent another thread from entering the critical section.
iv. At least one thread should be making progress.
v. There should be a bound on the time a thread must wait.

For each of four cases listed below there are only two threads, T1 and T2. Rather than use locks, the threads use the code below to provide mutual exclusion to a critical region. Each thread will be trying to access the critical region multiple times (i.e. not just once).

a.  (2 marks) T1 and T2 both execute the same function.
#define CLOSED 0
#define OPEN   1
volatile int Lock = OPEN; // global variable
AccessCriticalRegion() {
    while (Lock == CLOSED) {;} // busy wait
    Lock = CLOSED;
    CriticalSection();
    Lock = OPEN;
}
Does this scheme meet all the requirements? If not, which requirement is not satisfied? Give a scenario where that requirement would not be satisfied.

b.  (2 marks) Here T1 and T2 use different functions to access the critical region.
volatile int Last = 2; // global variable
// Code for T1
T1AccessCriticalRegion() {
    while (Last == 1){;}
    CriticalSection();
    Last = 1;
}
// Code for T2
T2AccessCriticalRegion() {
    while (Last == 2){;}
    CriticalSection();
    Last = 2;
}
Does this scheme meet all the requirements? If not, which requirement is not satisfied? Give a scenario where that requirement would not be satisfied.

c.  (2 marks) Here T1 and T2 use different functions to access the critical region.
#define WANT_IN 1
volatile int T1 = !WANT_IN; // global variables
volatile int T2 = !WANT_IN;
// Code for T1
T1AccessCriticalRegion() {
    T1 = WANT_IN;
    while (T2 == WANT_IN){;}
    CriticalSection();
    T1 = !WANT_IN;
}
// Code for T2
T2AccessCriticalRegion() {
    T2 = WANT_IN;
    while (T1 == WANT_IN){;}
    CriticalSection();
    T2 = !WANT_IN;
}
Does this scheme meet all the requirements? If not, which requirement is not satisfied? Give a scenario where that requirement would not be satisfied.

d.  (2 marks) Here T1 and T2 use different functions to access the critical region.
#define WANT_IN 1
volatile int T1 = !WANT_IN; // global variables
volatile int T2 = !WANT_IN;
volatile int Last = 1;
// Code for T1
T1AccessCriticalRegion() {
    while (1) {
       T1 = WANT_IN;
       if (T2 == !WANT_IN) {
         break;
       }
       if (Last == 1) {
         T1 = !WANT_IN;
         while (Last == 1){;}
       }
    }
    CriticalSection();
    Last = 1;
    T1 = !WANT_IN;
}
// Code for T2
T2AccessCriticalRegion() {
    while (1) {
      T2 = WANT_IN;
      if (T1 == !WANT_IN) {
        break;
      }
      if (Last == 2) {
        T2 = !WANT_IN;
        while (Last == 2){;}
      }
    }
    CriticalSection();
    Last = 2;
    T2 = !WANT_IN;
}
Does this scheme meet all the requirements? If not, which requirement is not satisfied? Give a scenario where that requirement would not be satisfied.

```json
{
  "problem_id": "8",
  "points": 8,
  "type": "Freeform",
  "tags": ["mutual-exclusion","synchronization","critical-section"],
  "answer": "a) This scheme can fail: it does not guarantee mutual exclusion due to non-atomic check-and-set (requirement i violated). Scenario: T1 reads Lock==OPEN and is preempted before writing CLOSED; T2 then also reads OPEN and enters the critical section, so both enter. b) This scheme violates requirement (iii) (and may violate fairness constraints): Last can prevent a thread from entering even though the other thread is not in its critical section. Example: Last==1 prevents T1 from running even if T2 is not active. c) This scheme can deadlock (violates iv progress): both set WANT_IN and then busy-wait on the other's flag, causing a deadlock where neither makes progress. d) This scheme (similar to Dekker's algorithm variant) is intended to work and can satisfy the requirements if implemented correctly; explain briefly why it enforces mutual exclusion and avoids deadlock and starvation.",
  "llm_judge_instructions": "Award up to 2 points per subpart: 1 point for identifying which requirement is violated (or stating it works), and 1 point for providing a clear scenario or brief justification. For part (d) if claimed correct, award 2 points only if justification of mutual exclusion and progress properties is concise and correct. Partial credit for partial or partially-correct reasoning."
}
```