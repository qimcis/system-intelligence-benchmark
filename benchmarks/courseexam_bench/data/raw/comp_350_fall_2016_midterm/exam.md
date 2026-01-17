# CS350 Fall 2016 Midterm

```json
{
  "exam_id": "comp_350_fall_2016_midterm",
  "test_paper_name": "CS350 Fall 2016 Midterm",
  "course": "COMP 350",
  "institution": "University of Waterloo",
  "year": 2016,
  "score_total": 52,
  "num_questions": 8
}
```

---

## Question 1 [10 point(s)]

1. (10 total marks)

Consider a concurrent program that includes two functions, called funcA and funcB. This program has the following synchronization requirements, both of which must be satisfied.

- Requirement 1: At most one thread at a time may be running funcB.
- Requirement 2: At most two threads at a time may be running any combination of funcA or funcB.

These requirements are summarized in the table below, which shows which combinations of funcA and funcB may be executed concurrently. Note that it is never OK for more than two threads to be running any combination of these functions concurrently.

Concurrent Function Execution Requirements
- funcA vs funcA: OK
- funcA vs funcB: OK
- funcB vs funcB: NO

a. (2 marks)
List the semaphores that you will use in your solution. For each semaphore, state what its initial value should be.

b. (8 marks)
Show the semaphore P and V operations that threads should perform before and after each call to funcA and funcB to enforce the synchronization requirements.

```

```json
{
  "problem_id": "1",
  "points": 10,
  "type": "Freeform",
  "tags": ["concurrency", "semaphores"],
  "answer": "a) SemA: initial value 2; SemB: initial value 1. b) Part a: P(SemA) before funcA and V(SemA) after funcA. Part b: P(SemB) then P(SemA) before funcB; funcB(); V(SemA); V(SemB) after. (Order of the final V calls is not important.)",
  "llm_judge_instructions": "Part a: award 2 points for correctly listing SemA and SemB with correct initial values. Part b: award up to 8 points total: 3 points for placing P(SemA) before funcA and V(SemA) after funcA; 5 points for the correct sequencing around funcB: P(SemB) and P(SemA) before, followed by funcB, then V(SemA) and V(SemB) after; allow either order for the final V calls."
}
```

---

## Question 2 [6 point(s)]

2. (6 total marks)

Suppose that a concurrent program has k threads, and that each thread is running on its own processor. The threads share access to a global variable, which is protected by a spinlock. To use the variable, each thread will first acquire the spinlock, then access the shared variable, then release the spinlock. Assume that when there is no contention (i.e., when only one thread is trying to access the shared variable), the total time required to acquire the lock, access the shared variable, and release the lock, is 10 time units.

a. (2 marks)
Suppose that each thread accesses the shared variable exactly one time, and that all k threads do so at exactly the same time, which we will refer to as time t = 0. At what time will the last of the threads finish releasing the spinlock?

b. (2 marks)
For the same scenario described in part (a), what is the total amount of time that the threads will spend spinning? In other words, what is the sum of the threads’ spinning times?

c. (2 marks)
For this part of the question, assume that there are k threads time-sharing a single processor. The first thing that each thread does when it is able to run is to acquire the spinlock and access the shared variable. Each thread accesses the shared variable one time. Assume that the scheduling quantum is larger than 10 time units. What is the total amount of time that the threads will spend spinning?

```

```json
{
  "problem_id": "2",
  "points": 6,
  "type": "Freeform",
  "tags": ["concurrency", "spinlock", "synchronization"],
  "answer": "a) t = 10k. b) total spinning time = 5(k^2 - k). c) 0.",
  "llm_judge_instructions": "Part a: 2 points for t = 10k. Part b: 2 points for 5(k^2 - k) (or a correct equivalent summation result). Part c: 2 points for 0. Award full points for exact expressions; award 1 point for partially correct reasoning or correct intermediate expressions in part b."
}
```

---

## Question 3 [8 point(s)]

3. (8 total marks)

Consider the following concurrent program:

volatile int numbers[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
volatile int value = 0;
static void myThreadA( void * junk, unsigned long num ){
    (void)junk;
    numbers[num] = value;
    thread_fork( "B", null, myThreadB, null, num );
    value = value + 1;
}
static void myThreadB( void * junk, unsigned long num ){
    (void)junk;
    numbers[num] = value;
}
int main(){
    for ( int i = 0; i < 10; i ++ )
        thread_fork( "A", null, myThreadA, null, i );
}

a. (2 marks)
Assuming that no errors occur, are the following values for numbers possible after all threads have finished executing? For each, answer “Yes” or “No”, and give a brief (one sentence) explanation.

- numbers = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

b. (2 marks)
- numbers = {0, 0, 0, 0, 0, 0, 0, 0, 0, 12}

c. (2 marks)
- numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}

d. (2 marks)
- numbers = {9, 8, 7, 6, 5, 4, 3, 2, 1, 0}

```

```json
{
  "problem_id": "3",
  "points": 8,
  "type": "Freeform",
  "tags": ["concurrency", "data-race"],
  "answer": "a) Yes; b) No; c) Yes; d) Yes.",
  "llm_judge_instructions": "Award 2 points for each subpart a-d; total 8 points. For each subpart award: 1 point for correct Yes/No and 1 point for a brief correct justification (one sentence)."
}
```

---

## Question 4 [10 point(s)]

4. (10 total marks)

Suppose that an application program contains a variable a, of type char *, which is a pointer to an array of characters. The program can then refer to the ith element of the array as a[i]. Each character occupies one byte, and C arrays are contiguous in the application’s virtual memory.

Suppose that the system uses 32-bit virtual and physical addresses and paged virtual memory, with a page size of 4KB (2^12 bytes). The valid entries in the process’s page table are shown in the following chart. Assume that the entries for any pages not listed in the chart are invalid.

Page #  Frame #
0x0001  0x0003
0x0001  0x0003
0x0001  0x0003
0x0001  0x0003
0x0001  0x0003

(The intention is: page 0x0001 -> frame 0x0003, page 0x0001 repeated lines are typographical in the original; ignore duplicates and use the mapping list below.)
Use the valid mappings:
- Page 0x0001 -> Frame 0x0003
- Page 0x00011 -> Frame 0x00033
- Page 0x00012 -> Frame 0x00010
- Page 0x00040 -> Frame 0x00021
- Page 0x00041 -> Frame 0x00022

The following table lists some possible values for the variables a and i. In each row, indicate what the physical address of a[i] will be, assuming the values of a and i indicated in that row, and the page table described above. If the virtual address of a[i] cannot be translated, write "exception".

Rows (virtual address of a[i] computed as virtual base a + i):
1) a = 0x000100F0, i = 0x100
2) a = 0x00012A0, i = 0x000
3) a = 0x0001305D, i = 0x2
4) a = 0x00040EF0, i = 0x1100
5) a = 0x00041F00, i = 0x100

For each row, state either the translated physical address or "exception".

```

```json
{
  "problem_id": "4",
  "points": 10,
  "type": "Freeform",
  "tags": ["virtual-memory", "address-translation"],
  "answer": "Row 1: 0x000321F0; Row 2: 0x00010A12; Row 3: exception; Row 4: 0x00022000; Row 5: exception.",
  "llm_judge_instructions": "Award 2 points per row (5 rows total) for a correct translation or 'exception' as specified. For each row: 1 point for correct page/offset decomposition and 1 point for correct frame+offset computation; if either step is incorrect, award partial credit accordingly."
}
```

---

## Question 5 [0 point(s)]

5. Draw the relevant stack frames for the OS161 process in the middle of calling fork. (Question describes parent and child stacks.) [This question requires a drawing and is omitted in this markdown to avoid diagrams.]

```

```json
{
  "problem_id": "5",
  "points": 0,
  "type": "Freeform",
  "tags": ["os161", "fork"],
  "answer": "",
  "llm_judge_instructions": ""
}
```

---

## Question 6 [6 point(s)]

6. (6 total marks)

a. (3 marks)
On the MIPS, the load linked (ll) and store conditional (sc) instructions are used to implement spinlocks. Suppose that two threads, T1 and T2, try to acquire an unlocked spinlock at the same time, and that their ll and sc instructions execute in the following order (ll from T1, then ll from T2, then sc from T1, then sc from T2). Which thread(s) will acquire the spinlock after this sequence? Answer one of the following: T1, T2, both, neither.

b. (3 marks)
Suppose that the MIPS spinlock was mistakenly implemented using a regular load instruction (lw, instead of ll) and a regular store instruction (sw, instead of sc). Suppose that the instruction sequence is the same as in part (a): lw from T1, lw from T2, sw from T1, sw from T2. Which thread(s) will believe that they have acquired the spinlock after this sequence? Answer one of the following: T1, T2, both, neither.

```

```json
{
  "problem_id": "6",
  "points": 6,
  "type": "Freeform",
  "tags": ["mips", "spinlock"],
  "answer": "a) T2. b) Both.",
  "llm_judge_instructions": "Part a: 3 points for identifying T2 as the acquirer; award points for correct explanation of the LL/SC semantics (why T1's SC fails and T2's succeeds). Part b: 3 points for identifying both threads and explanation that without LL/SC there is no atomic check-and-set, allowing both to believe they acquired the lock."
}
```

---

## Question 7 [6 point(s)]

7. (6 total marks)

a. (2 marks)
What is the difference between a thread yielding and a thread blocking?

b. (2 marks)
When an exception or interrupt occurs, a trap frame must be created to preserve the application’s context. This trap frame is put on a separate kernel stack, instead of the application’s stack: why? Provide at least two reasons.

c. (2 marks)
Both wait channels and condition variables can be used to make threads block. How does a wait channel differ from a condition variable? In particular, how does wchan_sleep differ from cv_wait?

```

```json
{
  "problem_id": "7",
  "points": 6,
  "type": "Freeform",
  "tags": ["os-kernel", "threads"],
  "answer": "a) Yield vs block: yield moves running -> ready; block moves to waiting for a resource and not ready. b) Trap frames on kernel stack reasons: the application stack pointer cannot be trusted, avoid exposing kernel data to application, and kernel may need its own stack space; at least two of these reasons suffice. c) Wait channel vs condition variable: wchan_sleep blocks the caller without implicitly releasing an associated lock; cv_wait blocks and atomically releases the associated lock, re-acquiring it before returning.",
  "llm_judge_instructions": "a) 2 points: full credit for stating running->ready vs running->blocked and noting scheduling implications. b) 2 points: award 1 point per correct reason (need at least two reasons for full credit). c) 2 points: 1 point for noting that CVs are used with locks and release the lock while sleeping, 1 point for noting wchan_sleep does not manage locks."
}
```

---

## Question 8 [6 point(s)]

8. (6 total marks)

a. (2 marks)
Process P calls the fork syscall and creates process C. Process P exits before process C exits. Assume that the kernel does not allow a process to call waitpid on any process except its children. Are any of the following statements definitely true at the time that P exits? Circle any that are true.
- Process P’s PID can be safely re-used by the kernel.
- Process C inherits process P’s PID.
- Process C terminates automatically.
- Process P will not be allowed to exit until C exits.

(Indicate which are definitely true, if any, and justify your answer in one sentence.)

b. (4 marks)
Consider a virtual memory system with 64-bit virtual addresses, and a page size of 32KB (2^15 bytes). The system uses multi-level paging. Each page table holds at most 2^13 entries, and each page table directory holds at most 2^12 entries. In the worst case, how many memory accesses are required to translate a virtual address to a physical address? Show your reasoning briefly.

```

```json
{
  "problem_id": "8",
  "points": 6,
  "type": "Freeform",
  "tags": ["virtual-memory", "paging"],
  "answer": "a) No statements are definitely true (all false). b) 4 memory accesses in the worst case (three index lookups into page-directory levels plus one final access to the page table entry / page).",
  "llm_judge_instructions": "Part a: 2 points for correctly identifying which statements (if any) are definitely true and providing a one-sentence justification. Part b: 4 points for computing the worst-case number of memory accesses: award points for correct decomposition of virtual address bits into levels and correct final count; partial credit for correct reasoning even if count is off."
}
```