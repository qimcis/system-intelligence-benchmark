# CS 350 Fall 2016 Midterm

```json
{
  "exam_id": "cs350_fall_2016_midterm",
  "test_paper_name": "CS 350 Fall 2016 Midterm",
  "course": "CS 350",
  "institution": "University of Waterloo",
  "year": 2016,
  "score_total": 54,
  "num_questions": 8
}
```

---

## Question 1 [10 point(s)]

1. (10 total marks)
Consider a concurrent program that includes two functions, called
funcA and funcB. This program has the following synchronization
requirements, both of which must be satisfied.

• Requirement 1: At most one thread at a time may be running funcB.
• Requirement 2: At most two threads at a time may be
  running any combination of funcA or funcB.

These requirements are summarized in the table on the right,
which shows which combinations of funcA and funcB may be
executed concurrently. Note that it is never OK for more than
two threads to be running any combination of these
functions concurrently.

funcA funcB
funcA OK OK
funcB OK NO

Concurrent Function
Execution Requirements

a. (2 marks)
List the semaphores that you will use in your solution. For each semaphore, state what its initial value should be.

b. (8 marks)
Show the semaphore P and V operations that threads should perform before and after each call to funcA and funcB to enforce the synchronization requirements. You must only use semaphores. Your solution should not be more restrictive than necessary, and it should ensure that deadlock is not possible.

```json
{
  "problem_id": "1",
  "points": 10,
  "type": "Freeform",
  "tags": ["concurrency","semaphores","synchronization"],
  "answer": "Part a: Use SemA with initial value 2 and SemB with initial value 1. Part b: For funcA: P(SemA) before calling funcA; V(SemA) after returning from funcA. For funcB: P(SemB); P(SemA) before calling funcB; after returning V(SemA); V(SemB).",
  "llm_judge_instructions": "Part a (2 pts): Award 2 pts if the answer lists both semaphores with the correct initial values (SemA = 2, SemB = 1). Award 1 pt if only one semaphore or one initial value is correct. Part b (8 pts): Award 4 pts for the correct sequence around funcA (P(SemA) before; V(SemA) after). Award 4 pts for the correct sequence around funcB (P(SemB) and P(SemA) before; V(SemA) and V(SemB) after; order of the two Vs after is not required). Do not deduct for minor ordering differences that do not affect correctness; deduct for missing semaphore operations or sequences that allow >2 concurrent threads or >1 concurrent funcB."
}
```

---

## Question 2 [6 point(s)]

2. (6 total marks)
Suppose that a concurrent program has k threads, and that each thread is running on its own processor.
The threads share access to a global variable, which is protected by a spinlock. To use the variable,
each thread will first acquire the spinlock, then access the shared variable, then release the spinlock.
Assume that when there is no contention (i.e., when only one thread is trying to access the shared
variable), the total time required to acquire the lock, access the shared variable, and release the lock
is 10 time units.

a. (2 marks)
Suppose that each thread accesses the shared variable exactly one time, and that all k threads do
so at exactly the same time, which we will refer to as time t = 0. At what time will the last of
the threads finish releasing the spinlock?

b. (2 marks)
For the same scenario described in part (a), what is the total amount of time that the threads
will spend spinning? In other words, what is the sum of the threads’ spinning times?

c. (2 marks)
For this part of the question, assume that there are k threads timesharing a single processor. The
first thing that each thread does when it is able to run is to acquire the spinlock and access the
shared variable. Each thread accesses the shared variable one time. Assume that the scheduling
quantum is larger than 10 time units. What is the total amount of time that the threads will
spend spinning?

```json
{
  "problem_id": "2",
  "points": 6,
  "type": "Freeform",
  "tags": ["concurrency","spinlocks","synchronization"],
  "answer": "a) t = 10k. b) Total spinning time = 10 * (k(k-1)/2) = 5(k^2 - k). c) 0.",
  "llm_judge_instructions": "Part a (2 pts): Award 2 pts for t = 10k. Part b (2 pts): Award 2 pts for the correct total spinning sum, expressed as 10 * sum_{i=0}^{k-1} i = 10 * (k(k-1)/2) (equivalently 5(k^2-k)). Award 1 pt for an equivalent unsimplified expression. Part c (2 pts): Award 2 pts for stating total spinning time is 0 and briefly noting that with a single processor timesharing and long quantum, threads do not spin while blocked on a spinlock because only one runs at a time."
}
```

---

## Question 3 [8 point(s)]

3. (8 total marks)
Consider the following concurrent program:

volatile int numbers[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
volatile int value = 0;

static void myThreadA(void * junk, unsigned long num) {
    (void)junk;
    numbers[num] = value;
    thread_fork("B", null, myThreadB, null, num);
    value = value + 1;
}

static void myThreadB(void * junk, unsigned long num) {
    (void)junk;
    numbers[num] = value;
}

int main() {
    for (int i = 0; i < 10; i++)
        thread_fork("A", null, myThreadA, null, i);
}

a. (2 marks)
Assuming that no errors occur, are the following values for numbers possible after all threads have
finished executing? For each, answer “Yes” or “No”, and give a brief (one sentence) explanation.
numbers = {0,0,0,0,0,0,0,0,0,0}

b. (2 marks)
numbers = {0,0,0,0,0,0,0,0,0,12}

c. (2 marks)
numbers = {1,2,3,4,5,6,7,8,9,10}

d. (2 marks)
numbers = {9,8,7,6,5,4,3,2,1,0}

```json
{
  "problem_id": "3",
  "points": 8,
  "type": "Freeform",
  "tags": ["concurrency","race-conditions","order-of-execution"],
  "answer": "a) Yes. b) No. c) Yes. d) Yes.",
  "llm_judge_instructions": "Each part is worth 2 pts. For each part, award 2 pts for the correct Yes/No answer together with a brief correct justification (one sentence). Award 1 pt if the answer is correct but justification is missing or incorrect."
}
```

---

## Question 4 [6 point(s)]

4. (6 total marks)
On the MIPS, the load linked (ll) and store conditional (sc) instructions are used to implement
spinlocks. Suppose that two threads, T1 and T2, try to acquire an unlocked spinlock at the same
time, and that their ll and sc instructions execute in the following order:

T1: ll
T2: ll
T1: sc
T2: sc

a. (3 marks)
Which thread(s) will acquire the spinlock after this sequence? Answer one of: T1, T2, both, neither.

b. (3 marks)
Suppose that the MIPS spinlock was mistakenly implemented using a regular load instruction (lw,
instead of ll) and a regular store instruction (sw, instead of sc). Suppose that the instruction
sequence is the same as in part (a):

T1: lw
T2: lw
T1: sw
T2: sw

Which thread(s) will believe that they have acquired the spinlock after this sequence? Answer one of: T1, T2, both, neither.

```json
{
  "problem_id": "4",
  "points": 6,
  "type": "Freeform",
  "tags": ["mips","spinlocks","concurrency"],
  "answer": "a) T2 acquires the spinlock. b) Both threads may believe they have acquired the spinlock with the incorrect lw/sw implementation.",
  "llm_judge_instructions": "Part a (3 pts): Award 3 pts for identifying T2 as the thread that acquires the lock; award 0-1 pt for partially correct reasoning. Part b (3 pts): Award 3 pts for identifying that both threads can believe they have the lock with lw/sw and explaining that the atomicity guarantee is lost; award 1-2 pts for partial reasoning."
}
```

---

## Question 5 [6 point(s)]

5. (6 total marks)

a. (2 marks)
What is the difference between a thread yielding and a thread blocking?

b. (2 marks)
When an exception or interrupt occurs, a trap frame must be created to preserve the application’s
context. This trap frame is put on a separate kernel stack, instead of the application’s stack: why? Give the main reasons.

c. (2 marks)
Both wait channels and condition variables can be used to make threads block. How does a
wait channel differ from a condition variable? In particular, how does wchan_sleep differ from cv_wait?

```json
{
  "problem_id": "5",
  "points": 6,
  "type": "Freeform",
  "tags": ["os","threads","synchronization"],
  "answer": "a) Yield: a running thread voluntarily moves to the ready state and can be scheduled again; Blocking: thread becomes not ready and waits for a resource/event. b) Trap frames are placed on a kernel stack because the user stack/pointer cannot be trusted, kernel state must be protected from user code, and kernel code cannot rely on user-space stack space. c) cv_wait releases an associated lock atomically while blocking and requires the lock to be held when called; wchan_sleep simply blocks on a wait channel and does not automatically release/reacquire a user-level lock.",
  "llm_judge_instructions": "Part a (2 pts): Award 2 pts for a clear distinction (running->ready vs running->blocked/waiting). Part b (2 pts): Award 2 pts for mentioning at least two of: user stack pointer untrusted, need to protect kernel data, and avoiding kernel's dependence on user stack memory. Part c (2 pts): Award 2 pts for stating that cv_wait is used with a lock and releases it atomically while blocking, whereas wchan_sleep blocks without that automatic lock-release semantics; award 1 pt for partial explanation."
}
```

---

## Question 6 [6 point(s)]

6. (6 total marks)
a. (3 marks)
On the MIPS, the load linked (ll) and store conditional (sc) instructions are used to implement
spinlocks. Suppose that two threads, T1 and T2, try to acquire an unlocked spinlock at the same
time, and that their ll and sc instructions execute in the following order:

T1: ll
T2: ll
T1: sc
T2: sc

Which thread(s) will acquire the spinlock after this sequence? Answer one of: T1, T2, both, neither.

b. (3 marks)
Suppose that the MIPS spinlock was mistakenly implemented using a regular load instruction (lw,
instead of ll) and a regular store instruction (sw, instead of sc). Suppose that the instruction
sequence is the same as in part (a):

T1: lw
T2: lw
T1: sw
T2: sw

Which thread(s) will believe that they have acquired the spinlock after this sequence? Answer one of: T1, T2, both, neither.

```json
{
  "problem_id": "6",
  "points": 6,
  "type": "Freeform",
  "tags": ["mips","spinlocks","concurrency"],
  "answer": "a) T2. b) Both threads may believe they have acquired the lock under the incorrect lw/sw implementation.",
  "llm_judge_instructions": "Part a (3 pts): Award 3 pts for identifying T2 and explaining that T1's sc fails because T2's later sc succeeds. Part b (3 pts): Award 3 pts for identifying that both threads can think they acquired the lock with lw/sw and explaining the lack of atomic conditional store; award partial credit for partial explanations."
}
```

---

## Question 7 [6 point(s)]

7. (6 total marks)

a. (2 marks)
What is the difference between a thread yielding and a thread blocking?

b. (2 marks)
When an exception or interrupt occurs, a trap frame must be created to preserve the application’s
context. This trap frame is put on a separate kernel stack, instead of the application’s stack: why? Give the main reasons.

c. (2 marks)
Both wait channels and condition variables can be used to make threads block. How does a
wait channel differ from a condition variable? In particular, how does wchan_sleep differ from cv_wait?

```json
{
  "problem_id": "7",
  "points": 6,
  "type": "Freeform",
  "tags": ["os","threads","synchronization"],
  "answer": "a) Yield: running->ready; can be scheduled again. Blocking: thread is removed from ready queue and waits for a resource/event. b) Kernel stack used because user stack pointer is untrusted, kernel must protect its data and avoid relying on user memory. c) cv_wait atomically releases an associated lock while blocking and requires that lock; wchan_sleep simply blocks on a wait channel without automatically releasing a user-level lock.",
  "llm_judge_instructions": "Same grading as Question 5: Part a (2 pts), Part b (2 pts for mentioning at least two reasons), Part c (2 pts for describing lock-release semantics difference)."
}
```

---

## Question 8 [6 point(s)]

8. (6 total marks)

a. (2 marks)
Process P calls the fork syscall and creates process C. Process P exits before process C exits.
Assume that the kernel does not allow a process to call waitpid on any process except its children.
Are any of the following statements definitely true at the time that P exits? Circle any that are true.
• Process P’s PID can be safely re-used by the kernel.
• Process C inherits process P’s PID.
• Process C terminates automatically.
• Process P will not be allowed to exit until C exits.

b. (4 marks)
Consider a virtual memory system with 64-bit virtual addresses, and a page size of 32KB (2^15 bytes).
The system uses multi-level paging. Each page table holds at most 2^13 entries, and each page table
directory holds at most 2^12 entries. In the worst case, how many memory accesses are required
to translate a virtual address to a physical address?

```json
{
  "problem_id": "8",
  "points": 6,
  "type": "Freeform",
  "tags": ["virtual-memory","paging","address-translation"],
  "answer": "a) None of the listed statements are definitely true. b) 4 memory accesses in the worst case (4-level page-table walk).",
  "llm_judge_instructions": "Part a (2 pts): Award 2 pts for stating that none are definitely true and briefly justifying (e.g., PID reuse policy, children PID inheritance not true, etc.). Part b (4 pts): Award 4 pts for correctly stating 4 memory accesses in the worst case and a brief explanation of the 4-level walk; award 2 pts for a partially correct level count."
}
```