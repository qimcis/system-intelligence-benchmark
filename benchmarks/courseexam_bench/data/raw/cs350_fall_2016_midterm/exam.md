# CS350 Fall 2016 Midterm

```json
{
  "exam_id": "cs350_fall_2016_midterm",
  "test_paper_name": "CS350 Fall 2016 Midterm",
  "course": "CS350",
  "institution": "University of Waterloo",
  "year": 2016,
  "score_total": 60,
  "num_questions": 18
}
```

---

## Question 1a [2 point(s)]

List the semaphores that you will use in your solution. For each semaphore, state what its initial value should be.

```json
{
  "problem_id": "1a",
  "points": 2,
  "type": "Freeform",
  "tags": ["concurrency", "semaphores", "synchronization"],
  "answer": "SemA: 2; SemB: 1",
  "llm_judge_instructions": "Award 2 points for correctly listing SemA and SemB with initial values SemA=2 and SemB=1. Award 1 point for partially correct identification of both semaphores or correct values (e.g., correct semaphores but one initial value incorrect, or only one semaphore correctly identified). 0 points otherwise."
}
```

---

## Question 1b [8 point(s)]

Show the semaphore PandV operations that threads should perform before and after each call to funcA and funcB to enforce the synchronization requirements.

```json
{
  "problem_id": "1b",
  "points": 8,
  "type": "Freeform",
  "tags": ["concurrency", "semaphores", "synchronization"],
  "answer": "P(SemA); funcA(); V(SemA); /* P/V around funcA */ /* order around funcB is constrained as shown */ P(SemB); P(SemA); funcB(); /* P/V around funcB */ V(SemA); V(SemB);",
  "llm_judge_instructions": "Award points according to the following rubric (total 8 points): 4 points for correct semaphore usage that ensures at most one thread may execute funcB at a time (i.e., correct use of SemB around funcB). 3 points for correct semaphore usage that ensures at most two threads total across funcA/funcB (i.e., correct initialization and use of SemA around funcA and funcB). 1 point for correct overall ordering or demonstrating that the sequence avoids deadlock. If parts are incorrect, award partial credit according to how many of the above criteria are satisfied. 0 points if the solution violates the specified constraints."
}
```

---

## Question 2a [2 point(s)]

Suppose that each thread accesses the shared variable exactly one time, and that all k threads do so at exactly the same time, which we will refer to as time t = 0. At what time will the last of the threads finish releasing the spinlock?

```json
{
  "problem_id": "2a",
  "points": 2,
  "type": "Freeform",
  "tags": ["spinlock", "synchronization"],
  "answer": "t = 10k",
  "llm_judge_instructions": "Award 2 points if the answer is t = 10k. 0 points otherwise."
}
```

---

## Question 2b [2 point(s)]

For the same scenario described in part (a), what is the total amount of time that the threads will spend spinning? In other words, what is the sum of the threads’ spinning times?

```json
{
  "problem_id": "2b",
  "points": 2,
  "type": "Freeform",
  "tags": ["spinlock", "spinning"],
  "answer": "total time = 10 * sum_{i=0}^{k-1} i",
  "llm_judge_instructions": "Award 2 points for the expression total time = 10 * sum_{i=0}^{k-1} i (or an equivalent expression). Award 1 point for showing the equivalent closed form 10 * (k(k-1)/2). 0 points otherwise."
}
```

---

## Question 2c [2 point(s)]

For this part of the question, assume that there are k threads timesharing a single processor. The first thing that each thread does when it is able to run is to acquire the spinlock and access the shared variable. Each thread accesses the shared variable one time. Assume that the scheduling quantum is larger than 10 time units. What is the total amount of time that the threads will spin?

```json
{
  "problem_id": "2c",
  "points": 2,
  "type": "Freeform",
  "tags": ["spinlock", "scheduling"],
  "answer": "None of the threads will spin (total spinning time is zero).",
  "llm_judge_instructions": "Award 2 points if the answer is that the total spinning time is zero, with a brief justification (e.g., each thread runs long enough to acquire the lock without spinning). 0 points otherwise."
}
```

---

## Question 3a [2 point(s)]

Assuming that no errors occur, are the following values for numbers possible after all threads have finished executing? For each, answer "Yes" or "No", and give a brief (one sentence) explanation.

numbers[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

```json
{
  "problem_id": "3a",
  "points": 2,
  "type": "Freeform",
  "tags": ["concurrency", "threads"],
  "answer": "Yes. This could occur if every myThreadB runs and exits before any myThreadA executes the increment.",
  "llm_judge_instructions": "Award 2 points for the correct answer 'Yes' together with a concise correct explanation. Award 1 point for the correct Yes/No with an incomplete explanation. 0 points otherwise."
}
```

---

## Question 3b [2 point(s)]

Repeat part (a), but for the following values for numbers:
numbers[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 12}

```json
{
  "problem_id": "3b",
  "points": 2,
  "type": "Freeform",
  "tags": ["concurrency", "threads"],
  "answer": "No. Value starts at 0, and is incremented at most 10 times, so it could never be 12, regardless of thread execution order.",
  "llm_judge_instructions": "Award 2 points for the correct answer 'No' with a concise correct explanation. 1 point for correct answer with unclear explanation. 0 points otherwise."
}
```

---

## Question 3c [2 point(s)]

Repeat part (a), but for the following values for numbers:
numbers[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}

```json
{
  "problem_id": "3c",
  "points": 2,
  "type": "Freeform",
  "tags": ["concurrency", "threads"],
  "answer": "Yes. This could occur if each pair myThreadA/myThreadB executes completely before the next myThreadA executes.",
  "llm_judge_instructions": "Award 2 points for the correct answer 'Yes' with a concise correct explanation. 1 point for partial reasoning. 0 points otherwise."
}
```

---

## Question 3d [2 point(s)]

Repeat part (a), but for the following values for numbers:
numbers[10] = {9, 8, 7, 6, 5, 4, 3, 2, 1, 0}

```json
{
  "problem_id": "3d",
  "points": 2,
  "type": "Freeform",
  "tags": ["concurrency", "threads"],
  "answer": "Yes. For example, this can occur if threads run in decreasing order, and each thread's myThreadB executes before incrementing value, and the next myThreadA does not run until the current thread has incremented value.",
  "llm_judge_instructions": "Award 2 points for the correct answer 'Yes' with a concise correct explanation. 1 point for partial reasoning. 0 points otherwise."
}
```

---

## Question 4 [10 point(s)]

Suppose that an application program contains a variable a, of type char *, which is a pointer to an array of characters. The program can then refer to the ith element of the array as a[i]. Each character occupies one byte, and C arrays are contiguous in the application's virtual memory. Suppose that the system uses 32-bit virtual and physical addresses and paged virtual memory, with a page size of 4KB (2^12 bytes). The valid entries in the process's page table are shown in the following chart. Assume that the entries for any pages not listed in the chart are invalid.

Page #  Frame #
0x000100 x00032
0x000110 x00033
0x000120 x00010
0x000400 x00021
0x000410 x00022

The following table lists some possible values for the variables a and i. In each row, indicate what the physical address of a[i] will be, assuming the values of a and i indicated in that row, and the page table described above. If the virtual address of a[i] cannot be translated, write "exception".

a[i]  pa[i]
0x000100F0  ?
0x00012A00  ?
0x0001305D  ?
0x00040EF0  ?
0x00041F00  ?
```

```json
{
  "problem_id": "4",
  "points": 10,
  "type": "Freeform",
  "tags": ["virtual-memory", "paging", "address-translation"],
  "answer": "",
  "llm_judge_instructions": "There are 5 rows. Award 2 points for each row that is correctly translated (correct physical address) or correctly marked 'exception' when translation is not possible. 0 points for an incorrect entry for that row."
}
```

---

## Question 5 [8 point(s)]

Draw the relevant stack frames for the application and kernel stacks for an OS161 process in the middle of calling fork. Assume that the parent process is in sys_fork (the kernel handler function for fork), and that the child process has been created and is about to call mips usermode. Draw the stacks of both the parent and child processes.

```json
{
  "problem_id": "5",
  "points": 8,
  "type": "Freeform",
  "tags": ["os161", "kernel", "process-management", "fork"],
  "answer": "",
  "llm_judge_instructions": "Award points according to the following rubric (total 8 points): 4 points for a correct and clearly labeled depiction of the parent's kernel and user stack frames relevant to sys_fork (including trap frame, registers saved, and any fork-related kernel frames). 4 points for a correct and clearly labeled depiction of the child's kernel and user stack frames (including the copied trap frame and correct return-to-user setup). Partial credit may be given (in multiples of 1 or 2 points) for partially correct diagrams."
}
```

---

## Question 6a [3 point(s)]

On the MIPS, the load linked (ll) and store conditional (sc) instructions are used to implement spinlocks. Suppose that two threads, T1 and T2, try to acquire an unlocked spinlock at the same time, and that their ll and sc instructions execute in the following order:
T1
T2
ll
time
ll
↓sc
sc
Which thread(s) will acquire the spinlock after this sequence? Answer one of the following: T1, T2, both, neither.

```json
{
  "problem_id": "6a",
  "points": 3,
  "type": "Freeform",
  "tags": ["mips", "ll_sc", "spinlock"],
  "answer": "T2 will acquire the spinlock.",
  "llm_judge_instructions": "Award 3 points if the answer is 'T2' with a correct brief explanation that T2's sc succeeds and T1's sc fails due to the ll/sc reservation semantics. Award 1 point if the answer is 'T2' without a correct explanation. 0 points otherwise."
}
```

---

## Question 6b [3 point(s)]

Suppose that the MIPS spinlock was mistakenly implemented using a regular load instruction (lw) instead of ll and a regular store instruction (sw) instead of sc. Suppose that the instruction sequence is the same as in part (a):
T1
T2
lw
time
lw
↓sw
sw
Which thread(s) will believe that they have acquired the spinlock after this sequence? Answer one of the following: T1, T2, both, neither.

```json
{
  "problem_id": "6b",
  "points": 3,
  "type": "Freeform",
  "tags": ["mips", "spinlock", "lw_sw"],
  "answer": "Both threads will believe they have acquired the spinlock.",
  "llm_judge_instructions": "Award 3 points if the answer is 'both' with a correct brief explanation (e.g., due to race between lw and sw, both stores can appear to succeed). Award 1 point if the correct label is given without explanation. 0 points otherwise."
}
```

---

## Question 7a [2 point(s)]

What is the difference between a thread yielding and a thread blocking?

```json
{
  "problem_id": "7a",
  "points": 2,
  "type": "Freeform",
  "tags": ["threading", "scheduling"],
  "answer": "A yielded thread moves from running to ready and can be scheduled again; a blocked thread is not running or ready and waits on a resource until it becomes available.",
  "llm_judge_instructions": "Award 2 points for a correct description: yielding moves a thread from running to ready (scheduler may reschedule it), blocking moves a thread to a waiting state until a resource/event occurs. 1 point for partial description. 0 points otherwise."
}
```

---

## Question 7b [2 point(s)]

When an exception or interrupt occurs, a trap frame must be created to preserve the application’s context. This trap frame is put on a separate kernel stack, instead of the application’s stack: why?

Possible answers:
• The stack pointer is an application-owned register, and thus can’t be trusted to be pointing at a valid stack.
• Using the application stack would expose kernel data to the application.
• Using the application stack would require the application to budget virtual memory for (unknown) kernel usage.

```json
{
  "problem_id": "7b",
  "points": 2,
  "type": "Freeform",
  "tags": ["os", "traps", "kernel"],
  "answer": "Using the application stack would expose kernel data to the application. The stack pointer is not trusted to point to a valid kernel stack in the application’s address space.",
  "llm_judge_instructions": "Award 2 points for stating either that using the application stack would expose kernel data to the application or that the user-controlled stack pointer cannot be trusted to point to a valid kernel stack (or both). Award 1 point for a partially correct reason. 0 points otherwise."
}
```

---

## Question 7c [2 point(s)]

Both wait channels and condition variables can be used to make threads block. How does a wait channel differ from a condition variable? In particular, how does wchan_sleep differ from cv_wait?

```json
{
  "problem_id": "7c",
  "points": 2,
  "type": "Freeform",
  "tags": ["wait-channel", "condition-variable"],
  "answer": "Wait channels block without requiring an associated lock; wchan_sleep blocks the thread until signaled on the channel, whereas cv_wait uses a lock and releases it while blocking, reacquiring it upon wakeup.",
  "llm_judge_instructions": "Award 2 points for correctly distinguishing that wchan_sleep does not require the caller to hold a mutex and operates on a wait-channel object, while cv_wait requires a mutex and releases/reacquires it atomically with sleeping. 1 point for partial correctness. 0 points otherwise."
}
```

---

## Question 8a [2 point(s)]

Process P calls the fork system call and creates process C. Process P exits before process C exits. Assume that the kernel does not allow a process to call waitpid on any process except its children. Are any of the following statements definitely true at the time that P exits? Circle any that are true.
• Process P’s PID can be safely re-used by the kernel.
• Process C inherits process P’s PID.
• Process C terminates automatically.
• Process P will not be allowed to exit until C exits.

```json
{
  "problem_id": "8a",
  "points": 2,
  "type": "Freeform",
  "tags": ["process-management", "fork", "exit"],
  "answer": "None of the statements are definitely true at P's exit.",
  "llm_judge_instructions": "Award 2 points for identifying that none of the listed statements are definitely true when P exits (brief justification optional). 1 point for a partially correct justification. 0 points otherwise."
}
```

---

## Question 8b [4 point(s)]

Consider a virtual memory system with 64-bit virtual addresses, and a page size of 32KB (2^15 bytes). The system uses multi-level paging. Each page table holds at most 2^13 entries, and each page directory holds at most 2^12 entries. In the worst case, how many memory accesses are required to translate a virtual address to a physical address?

```json
{
  "problem_id": "8b",
  "points": 4,
  "type": "Freeform",
  "tags": ["virtual-memory", "paging", "translation"],
  "answer": "4",
  "llm_judge_instructions": "Award 4 points if the answer matches the expected worst-case number of memory accesses as determined by the number of page-table levels plus the final data access (student should show reasoning). Award 2 points for a plausible but incomplete calculation. 0 points otherwise."
}
```