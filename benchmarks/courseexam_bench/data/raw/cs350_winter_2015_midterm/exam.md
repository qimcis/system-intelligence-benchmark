# CS350 Winter 2015 Midterm

```json
{
  "exam_id": "cs350_winter_2015_midterm",
  "test_paper_name": "CS350 Winter 2015 Midterm",
  "course": "CS350",
  "institution": "University of Waterloo",
  "year": 2015,
  "score_total": 53,
  "num_questions": 5
}
```

---

## Question 1 [9 point(s)]

{Question text ONLY - no answer, no solution in the text}

```json
{
  "problem_id": "1",
  "points": 9,
  "type": "Freeform",
  "tags": ["concurrency","multithreading"],
  "answer": "A: 42 | 20 | 30\nB: 42 | 10 | 30\nC: 42 | 10 | 20",
  "llm_judge_instructions": "Award 3 points for each line (A, B, C) that exactly matches the corresponding correct value. 3 pts for line A exact match; 3 pts for line B exact match; 3 pts for line C exact match. Total possible: 9 points."
}
```

---

## Question 2 [14 point(s)]

{Question text ONLY - no answer, no solution in the text}

```json
{
  "problem_id": "2",
  "points": 14,
  "type": "Freeform",
  "tags": ["processes","fork","exit-status"],
  "answer": "T: 42\nQ: 50\nA: 10\nD: 3\nR: 4\nM: 42\nP: 100",
  "llm_judge_instructions": "Award 14 points for an exact match of the entire output string including newline characters as shown. If the student's entire output exactly equals the answer string, award 14 points. If any character or line differs, award 0 points. Total possible: 14 points."
}
```

---

## Question 3 [12 point(s)]

{Question text ONLY - no answer, no solution in the text}

```json
{
  "problem_id": "3",
  "points": 12,
  "type": "Freeform",
  "tags": ["concurrency","barrier","threads"],
  "answer": "struct barrier {\n/* This MUST be volatile */\nvolatile unsigned int b_threads_reached;   /* how many have reached the barrier */\n/* This does not need to be volatile, only changed by one thread at init time */\nunsigned int b_threads_expected;           /* num threads to wait for*/\nstruct lock *b_lock;                       /* lock used to protect count and reached */\nstruct cv *b_cv;                           /* cv used to wait when needed */\n};\nstruct barrier *barrier_create(unsigned int thread_count)\n{\nstruct barrier *b = (struct barrier *) kmalloc(sizeof(barrier));\nb->b_lock = lock_create(\"barrier\");\nb->b_cv = cv_create(\"barrier\");\nb->b_threads_expected = thread_count;\nb->b_threads_reached = 0;\nreturn b;\n}\nbarrier_wait(struct barrier *b)\n{\nlock_acquire(b->b_lock);\nb->b_threads_reached++;\nif (b->b_threads_reached == b->b_threads_expected) {\n/* Must reset number of threads reached to use the barrier more than once */\n/* This could be done before or after broadcast */\nb->b_threads_reached = 0;\ncv_broadcast(b->b_cv, b->b_lock);\n} else {\ncv_wait(b->b_cv, b->b_lock);\n}\nlock_release(b->b_lock);\n}",
  "llm_judge_instructions": "Score breakdown (total 12 pts): barrier_create (4 pts): 1 pt for allocating the barrier structure, 1 pt for creating/assigning b_lock, 1 pt for creating/assigning b_cv, 1 pt for initializing b_threads_expected and b_threads_reached correctly. barrier_wait (8 pts): 2 pts for correctly acquiring and releasing the lock, 2 pts for correctly incrementing the reached count, 3 pts for correctly broadcasting/waking all waiting threads when reached equals expected, 1 pt for resetting b_threads_reached to allow reuse of the barrier. Partial credit awarded per item; total possible: 12 points."
}
```

---

## Question 4 [9 point(s)]

{Question text ONLY - no answer, no solution in the text}

```json
{
  "problem_id": "4",
  "points": 9,
  "type": "Freeform",
  "tags": ["virtual-memory","tlb","paging"],
  "answer": "a) The physical address from load at virtual address 6 125 273 127 604: translation not possible; TLB miss/exception. b) The physical address from store at virtual address 0 000 061 252 127: 30 130 252 127. c) A store to physical address 61 252 612 522: yes; virtual address 0 000 612 612 522.",
  "llm_judge_instructions": "Treat parts a, b, c as independent subparts. Award 3 points for part (a) if the student gives the correct result (exception/translation not possible) exactly as specified; award 3 points for part (b) if the student gives the exact correct translated physical address \"30 130 252 127\"; award 3 points for part (c) if the student gives the exact correct virtual address \"0 000 612 612 522\" and indicates that the store is possible. Total possible: 9 points."
}
```

---

## Question 5 [9 point(s)]

{Question text ONLY - no answer, no solution in the text}

```json
{
  "problem_id": "5",
  "points": 9,
  "type": "Freeform",
  "tags": ["virtual-memory","address-space","mips"],
  "answer": "a) Part of the stack segment. 0x4 0017 6429 - 0x4 0000 0000 = 0x17 6429; translation to 0x1 0017 6429. b) No translation. This address is not part of ANY segment. c) Part of the data segment. 0x8 0128 95FA - 0x8 0000 0000 = 0x128 95FA; translated to 0x3 0128 95FA.",
  "llm_judge_instructions": "Award 3 points for each part (a), (b), (c). For (a): 3 pts if student correctly identifies the segment as stack and gives the translation 0x1 0017 6429. For (b): 3 pts if student correctly states there is no translation because the address is not in any segment. For (c): 3 pts if student correctly identifies the data segment and gives the translation 0x3 0128 95FA. Total possible: 9 points."
}
```