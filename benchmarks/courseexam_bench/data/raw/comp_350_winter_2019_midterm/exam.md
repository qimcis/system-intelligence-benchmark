# CS350 Winter 2019 Midterm

```json
{
  "exam_id": "comp_350_winter_2019_midterm",
  "test_paper_name": "CS350 Winter 2019 Midterm",
  "course": "COMP 350",
  "institution": "University of Waterloo",
  "year": 2019,
  "score_total": 60,
  "num_questions": 7
}
```

---

## Question 1 [6 points]

For the following questions provide an answer and then justify your answer with a single sentence.
a.  (2 marks) Efficiency
Which is typically faster and why:
i  Printing the numbers from 1 to 1000000, one number at a time.
ii  Creating a string with the numbers from 1 to 1000000 and printing that string.

b.  (2 marks) Concurrency
Can  you  still  have concurrency  if  you  have  a  single  processor  with  a  single  core  and  the degree of
multithreading is one (i.e.  P=1, C=1, M=1).

c.  (2 marks) Synchronization
Can a lock be used anywhere a binary semaphore is used?

```json
{
  "problem_id": "1",
  "points": 6,
  "type": "Freeform",
  "tags": ["efficiency", "concurrency", "synchronization"],
  "answer": "a) B is faster. b) yes. c) No.",
  "llm_judge_instructions": "Part a: award 2 points for identifying that printing the entire sequence as a single string is typically faster due to fewer system calls. Part b: 2 points for the correct answer 'yes' with justification mentioning preemption/timesharing. Part c: 2 points for the correct answer 'No' and note that locks require explicit acquire/release while binary semaphores can be used more flexibly."
}
```

---

## Question 2 [10 points]

For the following questions point form answers are preferred.
a.  (2 marks) Concurrency
List two possible advantages of concurrency.
b.  (4 marks) Context SwitchingThere are a number of ways that a context switch can occur.
i  Which ones are prevented when interrupts are turned off.
ii  Which ones are prevented when each process only has a single thread of execution.
iii  Which ones are not prevented by either of the two previous conditions.
c.  (4 marks) cvwait
List, in order, the four steps of cv_wait.  Do not list any of the KASSERTs.
1.
2.
3.
4.

```json
{
  "problem_id": "2",
  "points": 10,
  "type": "Freeform",
  "tags": ["concurrency", "context-switching", "cv-wait"],
  "answer": "a) Improved CPU utilization; Improved performance. b) i preemption; ii none; iii Threadexit, Threadyield, Thread block or sleep. c) 1) wchanlock(cv->wchan) 2) lockrelease(lk) 3) wchansleep(cv->wchan) 4) lock_acquire(lk).",
  "llm_judge_instructions": "Part a: 2 points for two valid advantages. Part b: 4 points distributed as 1) prevented when interrupts are off (preemption), 2) when each process has a single thread (none), 3) not prevented by either (Threadexit, Threadyield, Thread block or sleep) with up to 4 points total. Part c: 4 points for correctly listing the four steps in order."
}
```

---

## Question 4 [10 points]

The following pseudocode makes use of a semaphore.  Replace the semaphore based implementation with
a condition variable based implementation that performs the same task.  You may only add up to three
additional variables. Your cv may not be used with a loop.
Semaphore barrier; // initialized to 0
int CS350( void * v, long n )
{
WriteMidterm()
V(barrier);
}
int main()
{
for ( int i = 0; i <  NUMTHREADS; i ++ )
thread_fork(‘‘student’’, null, CS350, null, i );
for ( int i = 0; i < NUMTHREADS; i ++ )
P( barrier );
MarkMidterms()
}

```json
{
  "problem_id": "4",
  "points": 10,
  "type": "Freeform",
  "tags": ["synchronization", "condition-variables"],
  "answer": "Replace barrier semaphore with a condition variable barrier: use a mutex-protected counter (count) and a barrier CV; threads increment count under lock, and if count == NUMTHREADS signal barrier; in main, after forking threads, wait on barrier with cv_wait until count equals NUMTHREADS.",
  "llm_judge_instructions": "Award full 10 points for a correct CV-based barrier replacement. Partial credit for correct core idea (using a mutex, a counter, and a barrier CV) with incomplete details."
}
```

---

## Question 5 [10 points]

Consider the following implementation of a lock.  Assume that sem is created with an initial count of 1.
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
(a)  If this lock was used to protect a critical section, would it guarantee mutual exclusion?

(b)  If you answered yes to (a), why?  If you answered no to (a), correct the code (you may edit the code
in-place).
(c)  If there are any other issues with the lock not related to mutual exclusion, correct them.  Otherwise,
indicate the implementation is correct.

```json
{
  "problem_id": "5",
  "points": 10,
  "type": "Freeform",
  "tags": ["locks", "synchronization"],
  "answer": "a) No. b) Corrected version would explicitly enforce mutual exclusion by ensuring the owner is NULL before acquiring and by proper wake-up semantics in release. c) Additional issues include potential wakeups and ordering; the corrected version should ensure owner checks and proper signaling.",
  "llm_judge_instructions": "Part (a) awards 2 points if the given lock does not guarantee mutual exclusion. Part (b) awards up to 6 points for providing a corrected implementation, including proper owner checks and wakeup semantics. Part (c) awards up to 2 points for identifying other issues and confirming correctness or providing fixes."
}
```

---

## Question 6 [8 points]

A  system  uses  segmented  address  space  for  its  implementation  of  virtual  memory.   Suppose  a  process
initially uses 48KB of memory for its heap.  The process then runs low on heap space and requests 16 KB
more space.  Assume you have access to a procedure sbrk and that sbrk(16*1024) will request that the
heap’s space be increase by 16 KB by finding a new location in RAM for the heap segment.  If successful
it returns the new address, otherwise it return NULL.
In roughly 4–6 steps, describe the process that would be required to increase the process’s address space.

```json
{
  "problem_id": "6",
  "points": 8,
  "type": "Freeform",
  "tags": ["virtual-memory", "sbrk", "heap"],
  "answer": "1) Check available address space for the expanded heap; if insufficient, return ENOMEM. 2) Allocate a new heap region of 16KB. 3) Copy old heap contents to the new region. 4) Update the process's heap base/limit and the MMU mappings. 5) Update relocation/limit values in the kernel. 6) Deallocate the old heap region.",
  "llm_judge_instructions": "Award 8 points for a sequence of steps describing the checks, allocation, data copy, updates to kernel/MMU, and deallocation of the old region."
}
```

---

## Question 7 [8 points]

A system uses 24-bit virtual addresses, 24-bit physical addresses and memory segmentation.  There are
four segments and two bits are used for the segment number.  The relocation and limit for each of the
segments are as follows.
Segment
Number
Limit
Register
Relocation
Register
0x0    0x2 0000   0x40 0000
0x1    0xC 0000   0x70 0000
0x2    0x9 0000   0x50 0000
0x3    0xA 0000   0x60 0000
Translate the following addresses from virtual to physical.  Clearly indicate what segment each address
belongs to.
a.  (2 marks)0x01 D0D4
Segment Number:
Address Translation:
b.  (2 marks)0x22 CA10
Segment Number:
Address Translation:
c.  (2 marks)0x33 47B8
Segment Number:
Address Translation:
d.  (2 marks)0x1C F008
Segment Number:
Address Translation:

```json
{
  "problem_id": "7",
  "points": 8,
  "type": "Freeform",
  "tags": ["segmented-memory", "address-translation"],
  "answer": "a) Segment Number: 0; Address Translation: 0x41D0D4. b) Segment Number: 0; Address Translation: segmentation violation. c) Segment Number: 0; Address Translation: segmentation violation. d) Segment Number: 0; Address Translation: segmentation violation.",
  "llm_judge_instructions": "Award 2 points each for correct segment identification and translation, or correct segmentation violations as indicated in the provided solutions."
}
```

---

## Question 8 [8 points]

Ideally any scheme to enforce mutual exclusion should satisfy the following constraints.
i.  Only one thread is allowed in a critical section at a time.
ii.  No assumptions can be made about the order different threads will access the critical section.
iii.  A thread that is outside the critical section cannot prevent another thread from entering the critical
section.
iv.  At least one thread should be making progress.
v.  There should be a bound on the time a thread must wait.
For each of four cases listed below there are only two threads, T1 and T2.  Rather than use locks, the
threads use the code below to provide mutual exclusion to a critical region.  Each thread will be trying
to access the critical region multiple time (i.e.  not just once).
a.  (2 marks)T1 and T2 both execute the same function.
#define CLOSED 0
#define OPEN   1
volatile int Lock = OPEN; // global variable
AccessCriticalRegion() {
1    while (Lock == CLOSED) {;} // busy wait
2    Lock = CLOSED;
3    CriticalSection();
4    Lock = OPEN;
}
Does this scheme meet all the requirements?
If not, which requirement is not satisified?  Give a scenario where that requirement would not be satisfied.
b.  (2 marks)Here T1 and T2 use different functions to access the critical region.
volatile int Last = 2; // global variable
// Code for T1
T1AccessCriticalRegion() {
1   while (Last == 1){;}
2   CriticalSection();
3   Last = 1;
}
// Code for T2
T2AccessCriticalRegion() {
1   while (Last == 2){;}
2   CriticalSection();
3   Last = 2;
}
Does this scheme meet all the requirements?
If not, which requirement is not satisified?  Give a scenario where that requirement would not be satisfied.
c.  (2 marks)Here T1 and T2 use different functions to access the critical region.
#define WANT_IN 1
volatile int T1 = ! WANT_IN; // global variables
volatile int T2 = ! WANT_IN;
// Code for T1
T1AccessCriticalRegion() {
1   T1 = WANT_IN;
2   while (T2 == WANT_IN){;}
3   CriticalSection();
4   T1 = ! WANT_IN;
}
// Code for T2
T2AccessCriticalRegion() {
1   T2 = WANT_IN;
2   while (T1 == WANT_IN){;}
3   CriticalSection();
4   T2 = ! WANT_IN;
}
Does this scheme meet all the requirements?
If not, which requirement is not satisified?  Give a scenario where that requirement would not be satisfied.
d.  (2 marks)Here T1 and T2 use different functions to access the critical region.
#define WANT_IN 1
volatile int T1 = ! WANT_IN; // global variables
volatile int T2 = ! WANT_IN;
volatile int Last = 1;
// Code for T1
T1AccessCriticalRegion() {
1   while (1) {
2      T1 = WANT_IN;
3      if (T2 == !WANT_IN) {
4         break;
5      }
6     if (Last == 1) {
7        T1 = !WANT_IN;
8        while (Last == 1){;}
9     }
10   }
11  CriticalSection();
12  Last = 1;
13  T1 = !WANT_IN;
}
// Code for T2
T2AccessCriticalRegion() {
1  while (1) {
2    T2 = WANT_IN;
3    if (T1 == !WANT_IN) {
4      break;
5    }
6    if (Last == 2) {
7      T2 = !WANT_IN;
8      while (Last == 2){;}
9    }
10  }
11  CriticalSection();
12  Last = 2;
13  T2 = !WANT_IN;
}
Does this scheme meet all the requirements?
If not, which requirement is not satisified?  Give a scenario where that requirement would not be satisfied.

```json
{
  "problem_id": "8",
  "points": 8,
  "type": "Freeform",
  "tags": ["mutual-exclusion", "synchronization"],
  "answer": "a) It does not meet all requirements; it may fail to guarantee mutual exclusion under certain interleavings (e.g., both threads observe OPEN and enter). b) It does not meet requirement (iii) or (ii) depending on timing; c) It may fail on progress or deadlock in some interleavings; d) It is claimed to work but would require rigorous proof.",
  "llm_judge_instructions": "Provide scoring rubrics for each option, highlighting which constraints fail and giving example interleavings or scenarios."
}
```