# CS 350 Spring 2014 Midterm

```json
{
  "exam_id": "cs350_spring_2014_midterm",
  "test_paper_name": "CS 350 Spring 2014 Midterm",
  "course": "CS 350",
  "institution": "University of Waterloo",
  "year": 2014,
  "score_total": 60,
  "num_questions": 7
}
```

---

## Question 1 [6 point(s)]

{Question text from the exam (Question 1 with parts a, b, and c) }

```json
{
  "problem_id": "1",
  "points": 6,
  "type": "Freeform",
  "tags": ["processes","fork","synchronization"],
  "answer": "a) Four processes. b) 1 2 1 0 1 0. c) Example possible output: 1 1 0 0 2 1",
  "llm_judge_instructions": "Part (a): Award 2 points for exactly stating 'Four processes' (or equivalent). Part (b): Award 2 points for the exact sequence '1 2 1 0 1 0'. Part (c): Award 2 points for providing a valid example sequence that could be produced by the modified program but not by the original, with the required counts and ordering constraints (the sequence '1 1 0 0 2 1' is one valid example). Partial credit: 1 point for correctly identifying the quantity in (a); 1 point for a plausible but not exact (b) sequence; 1 point for a partially correct (c) justification if partial constraints are met."
}
```

---

## Question 2 [10 point(s)]

{Question text from the exam (Question 2 with parts a and b) }

```json
{
  "problem_id": "2",
  "points": 10,
  "type": "Freeform",
  "tags": ["locks","synchronization"],
  "answer": "a) int locktryacquire(struct lock *lock){\n    spinlock_acquire(&lock->spinlock);\n    if (lock->holder == NULL){\n        lock->holder = curthread;\n        spinlock_release(&lock->spinlock);\n        return 1;\n    }else{\n        spinlock_release(&lock->spinlock);\n        return 0;\n    }\n}\nb) void acquiretwolocks(struct lock *L1, struct lock *L2){\n    lockacquire(L1);\n    while ( locktryacquire(L2) == 0 ){\n        lockrelease(L1);\n        lockacquire(L1);\n    }\n    return;\n}",
  "llm_judge_instructions": "Part (a): Award 5 points for a correct, atomic locktryacquire implementation that acquires when free and returns 1, otherwise does not block and returns 0. Include proper spinlock handling. Part (b): Award 5 points for a correct acquiretwolocks implementation that never blocks while holding one lock (no hold-and-wait), using only the two input locks and the allowed primitives. Partial: up to 2 points for a function that compiles but has logical issues; 1 point for partially correct structure."
}
```

---

## Question 3 [8 point(s)]

{Question text from the exam (Question 3 with subparts a, b, c) }

```json
{
  "problem_id": "3",
  "points": 8,
  "type": "Freeform",
  "tags": ["synchronization","locks","condition-variables"],
  "answer": "a) struct lock *mutex; struct cv *cv; volatile int numanimals = NumCats + NumMice;\nb) lockacquire(mutex);\nwhile (numanimals > 0){\n    cv_wait(cv, mutex);\n}\nlockrelease(mutex);\nc) lockacquire(mutex);\nnumanimals--;\nif (numanimals == 0){\n    cv_signal(cv, mutex);\n}\nlockrelease(mutex);",
  "llm_judge_instructions": "Part (a): Award 2 points for declaring the required synchronization primitives with an initial value for shared variables. Part (b): Award 3 points for correct waiting code using the condition variable (cv_wait) and the mutex. Part (c): Award 3 points for the corresponding code that signals the condition variable when the last thread finishes. Partial: 1–2 points for partially correct declarations or await loops; 1–2 points for partial signaling logic."
}
```

---

## Question 4 [6 point(s)]

{Question text from the exam (Question 4 with the ll/sc table) }

```json
{
  "problem_id": "4",
  "points": 6,
  "type": "Freeform",
  "tags": ["assembly","synchronization","ll-sc","locks"],
  "answer": "Value of R0, Value of R1 and the corresponding statements for each of the four cases in the table: 00 Not possible to determine whether the lock is held. 01 The lock holds. 10 Not possible to determine whether the lock is held. 11 Some thread holds the lock.",
  "llm_judge_instructions": "Part (a): Provide the correct mapping for each (R0, R1) pair to one of the four statements: 'holds the lock', 'Some thread other than holds the lock', 'No thread holds the lock', 'Not possible to determine whether the lock is held'. Award up to 6 points total—1.5 points per cell, with full credit for correct mapping of all four cells. Partial: 0–1.5 points per cell if correct; 0 if incorrect."
}
```

---

## Question 5 [6 point(s)]

{Question text from the exam (Question 5 with parts a, b, c) }

```json
{
  "problem_id": "5",
  "points": 6,
  "type": "Freeform",
  "tags": ["scheduling","preemption"],
  "answer": "a) 100b\nb) 100q\nc) 100kq",
  "llm_judge_instructions": "Award 2 points for each subpart correct: a) correctly derives 100*b, b) 100*q, c) 100*k*q. Partial: 1 point per subpart if partially correct (e.g., expressions missing factors or misinterpretation of variables)."
}
```

---

## Question 6 [8 point(s)]

{Question text from the exam (Question 6 with description and skeleton code) }

```json
{
  "problem_id": "6",
  "points": 8,
  "type": "Freeform",
  "tags": ["semaphores","concurrency","queues"],
  "answer": "See skeleton code with P and V insertions for AtoB and BtoA as provided in the exam text, ensuring: (1) dequeue never on empty queue, (2) mutual exclusion per queue, (3) preserve enqueue order across queues, (4) no deadlocks; multiple queues may be used concurrently.",
  "llm_judge_instructions": "Award up to 8 points for correctly inserting semaphore operations to satisfy the four requirements: (1) prevent dequeue on empty, (2) serialize access per queue, (3) preserve inter-queue ordering, (4) avoid deadlock and permit concurrent usage of different queues. Partial: up to 2 points per requirement if partially satisfied; 0 if none."
}
```

---

## Question 7 [16 point(s)]

{Question text from the exam (Question 7 with parts a–h) }

```json
{
  "problem_id": "7",
  "points": 16,
  "type": "Freeform",
  "tags": ["mips","syscall","kernel","scheduling"],
  "answer": "a) The following apply: the current value of the program counter is saved; a trap frame is saved; the processor switches to privileged execution mode; the value of the program counter is changed. b) A ready thread is runnable and will run again as soon as the scheduler chooses it to run. A blocked thread will not become runnable again until another process wakes it up (via wakeone or wakeall). c) Disabling interrupts on one processor will not prevent a thread on another processor from entering the critical section. d) False. e) True. f) System calls, interrupts, and exceptions. g) One trap frame on P’s thread’s kernel stack. h) One switch frame on P’s thread’s kernel stack.",
  "llm_judge_instructions": "Provide full credit (16 points) for correctly answering all eight subparts. Partial credit: award up to 2 points per subpart (a through h) based on partial correctness and justification. For (a), list all applicable effects; for (b)–(h), succinctly state the correct concept with a brief justification where appropriate."
}
```

---