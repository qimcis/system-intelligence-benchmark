# CS350 Midterm Examination Fall 2016

```json
{
  "exam_id": "comp_350_fall_2016_midterm",
  "test_paper_name": "CS350 Midterm Examination Fall 2016",
  "course": "COMP 350",
  "institution": "University of Waterloo",
  "year": 2016,
  "score_total": 52,
  "num_questions": 7
}
```

---

## Question 1 [10 total marks]

Consider a concurrent program that includes two functions, called
funcA and funcB. This program has the following synchronization
requirements, both of which must be satisfied.

• Requirement 1: At most one thread at a time may be running funcB.  
• Requirement 2: At most two threads at a time may be
running any combination of funcA or funcB.

These requirements are summarized in the table on the right,
which shows which combinations of funcA and funcB may be
executed concurrently. Note that it is never OK for more than
two threads to be running any combination of these functions
concurrently.

funcA  funcB
funcA  OK    OK
funcB  OK    NO

Concurrent Function
Execution Requirements

a. (2 marks)  
List the semaphores that you will use in your solution. For each semaphore, state what its initial value should be.

b. (8 marks)  
Show the semaphore P and V operations that threads should perform before and after each call to funcA and funcB to enforce the synchronization requirements. You must not use any synchronization primitives other than semaphores. Your solution should not be more restrictive than necessary, and it should ensure that deadlock is not possible.

```json
{
  "problem_id": "1",
  "points": 10,
  "type": "Freeform",
  "tags": ["semaphores", "concurrency"],
  "answer": "a) Semaphores: SemA (initial value 2), SemB (initial value 1).\nb) P/V operations:\n   Around funcA: P(SemA); funcA(); V(SemA);\n   Around funcB: P(SemB); P(SemA); funcB(); V(SemA); V(SemB);\n   (the two P(SemA)/V(SemA) around funcA are paired; the P(SemB) and P(SemA) before funcB must occur in that order; V(SemA) and V(SemB) after funcB are the final releases.)",
  "llm_judge_instructions": "Award full points for correctly identifying SemA and SemB with their initial values, and for providing the exact P and V sequence around funcA and around funcB as shown in the solution. Partial credit can be given for correctly listing the semaphores and the general structure of the operations (e.g., correctly associating P(SemA)/V(SemA) with funcA and the P(SemB); P(SemA) before funcB, followed by V(SemA); V(SemB) after)."
}
```

---

## Question 2 [6 total marks]

Suppose that a concurrent program has k threads, and that each thread is running on its own processor.
The threads share access to a global variable, which is protected by a spinlock. To use the variable,
each thread will first acquire the spinlock, then access the shared variable, then release the spinlock.
Assume that when there is no contention (i.e., when only one thread is trying to access the shared
variable), the total time required to acquire the lock, access the shared variable, and release the lock,
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
  "tags": ["spinlock", "concurrency"],
  "answer": "a) t = 10k\nb) total spinning time = 5(k^2 - k)\nc) zero spinning time (no spinning when quantum > 10).",
  "llm_judge_instructions": "Award full points for the three parts: (a) last thread finishes at t = 10k; (b) spinning time equals 5(k^2 - k); (c) zero spinning time. Provide partial credit if only some parts are correct."
}
```

---

## Question 3 [8 total marks]

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

numbers[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

b. (2 marks)  
Repeat part (a), but for the following values for numbers:

numbers[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 12}

c. (2 marks)  
Repeat part (a), but for the following values for numbers:

numbers[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}

d. (2 marks)  
Repeat part (a), but for the following values for numbers:

numbers[10] = {9, 8, 7, 6, 5, 4, 3, 2, 1, 0}

```json
{
  "problem_id": "3",
  "points": 8,
  "type": "Freeform",
  "tags": ["concurrency", "data-races"],
  "answer": "a) Yes; e.g., all B threads finish before any A thread increments value. b) No; value can’t reach 12. c) Yes; possible if each A/B pair completes before next A. d) Yes; possible with decreasing execution order where B runs before the next A increments value.",
  "llm_judge_instructions": "Award full points for the four subparts with correct Yes/No answers and brief explanations. Provide partial credit if partial reasoning is correct."
}
```

---

## Question 4 [10 total marks]

Suppose that an application program contains a variable a, of type char *, which is a pointer to an
array of characters. The program can then refer to the i th element of the array as a[i]. Each character
occupies one byte, and C arrays are contiguous in the application’s virtual memory.

Suppose that the system uses 32-bit virtual and physical addresses and paged virtual memory, with a
page size of 4KB (2^12 bytes). The valid entries in the process’s page table are shown in the following
chart. Assume that the entries for any pages not listed in the chart are invalid.

Page #   Frame #
0x00010  0x00032
0x00011  0x00033
0x00012  0x00010
0x00040  0x00021
0x00041  0x00022

The following table lists some possible values for the variables a and i. In each row, indicate what the
physical address of a[i] will be, assuming the values of a and i indicated in that row, and the page
table described above. If the virtual address of a[i] cannot be translated, write "exception".

a                i
0x000100F0       0x100
0x00012A00       0x120
0x0001305D       0x2
0x00040EF0       0x110
0x00041F00       0x100

```json
{
  "problem_id": "4",
  "points": 10,
  "type": "Freeform",
  "tags": ["virtual-memory", "paging"],
  "answer": "Row 1 -> 0x000321F0; Row 2 -> 0x00010A12; Row 3 -> exception; Row 4 -> 0x00022000; Row 5 -> exception",
  "llm_judge_instructions": "Match the computed physical addresses or exceptions for each row as described, based on the provided page table and virtual addresses."
}
```

---

## Question 6 [6 total marks]

a. (3 marks)  
On the MIPS, the load linked (ll) and store conditional (sc) instructions are used to implement
spinlocks. Suppose that two threads, T1 and T2, try to acquire an unlocked spinlock at the same
time, and that their ll and sc instructions execute in the following order:

T1: ll
T2: ll
T1: sc
T2: sc

Which thread(s) will acquire the spinlock after this sequence? Answer one of the following: T1, T2, both, neither.

b. (3 marks)  
Suppose that the MIPS spinlock was mistakenly implemented using a regular load instruction (lw,
instead of ll) and a regular store instruction (sw, instead of sc). Suppose that the instruction
sequence is the same as in part (a):

T1: lw
T2: lw
T1: sw
T2: sw

Which thread(s) will believe that they have acquired the spinlock after this sequence? Answer
one of the following: T1, T2, both, neither.

```json
{
  "problem_id": "6",
  "points": 6,
  "type": "Freeform",
  "tags": ["mips", "spinlock"],
  "answer": "a) T2 will acquire the spinlock. b) Both threads will believe they have acquired the spinlock.",
  "llm_judge_instructions": "Award full points for correctly identifying the outcome in both parts. Provide brief justification if needed."
}
```

---

## Question 7 [6 total marks]

a. (2 marks)  
What is the difference between a thread yielding and a thread blocking?

b. (2 marks)  
When an exception or interrupt occurs, a trap frame must be created to preserve the application’s
context. This trap frame is put on a separate kernel stack, instead of the application’s stack: why?
Possible answers include: the stack pointer is an application-owned register and thus can't be trusted; using the application stack would expose kernel data to the application; using the application stack would require the application to budget virtual memory for kernel usage.

c. (2 marks)  
Both wait channels and condition variables can be used to make threads block. How does wchan sleep differ from cv wait?

```json
{
  "problem_id": "7",
  "points": 6,
  "type": "Freeform",
  "tags": ["threading", "synchronization"],
  "answer": "a) Difference: yield moves a thread from running to ready; blocking moves it to a blocked state awaiting a resource. b) Trap frame on kernel stack because kernel context must be protected and the application stack cannot be trusted for kernel usage (and to avoid exposing kernel data to user). c) Wait channels block without an associated lock in the wait channel model, while condition variables require a lock and CV wait releases the lock atomically; wait channel sleep blocks the thread, CV wait releases lock and blocks as part of the wait.",
  "llm_judge_instructions": "Award full points for each subpart with correct explanations. Partial credit for partially correct explanations."
}
```

---

## Question 8 [6 total marks]

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
  "tags": ["virtual-memory", "paging"],
  "answer": "a) None of the statements are definitely true (P may exit before C; P may or may not be allowed to wait for C; C may or may not terminate automatically; PID reuse not guaranteed). b) 4 memory accesses in the worst case.",
  "llm_judge_instructions": "Provide rubric: (a) identify which statements are definitely true; (b) 4 accesses in worst case. Accept partial reasoning."
}
```

---