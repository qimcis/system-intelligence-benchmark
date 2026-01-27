# CS 537 Spring 2018 Midterm

```json
{
  "exam_id": "cs537_spring_2018_midterm",
  "test_paper_name": "CS 537 Spring 2018 Midterm",
  "course": "CS 537",
  "institution": "University of Wisconsin-Madison",
  "year": 2018,
  "score_total": 30,
  "num_questions": 30
}
```

---

## Question 1 [5 point(s)]

Problem I: A program’s main function is as follows:
```c
int main(int argc, char *argv[]) {
  char *str = argv[1];
  while (1)
    printf("%s", str);
  return 0;
}
```
Two processes, both running instances of this program, are currently running. The programs were invoked as follows (a "parallel command"):
wish> main a && main b
Below are possible (or impossible?) screen captures of some of the output from the beginning of the run of the programs. Which of the following are possible? To answer: Fill in A for possible, B for not possible.

1. abababab ...
2. aaaaaaaa ...
3. bbbbbbbb ...
4. aaaabbbb ...
5. bbbbaaaa ...

```json
{
  "problem_id": "1",
  "points": 1,
  "type": "Freeform",
  "tags": ["concurrency"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 2 [3 point(s)]

Problem II: Here is source code for another program, called increment.c:
```c
int value = 0;
int main(int argc, char *argv[]) {
  while (1) {
    printf(\"%d\", value);
    value++;
  }
  return 0;
}
```
While increment.c is running, another program, reset.c, is run once as a separate process. Here is the source code of reset.c:
```c
int value;
int main(int argc, char *argv[]) {
  value = 0;
  return 0;
}
```
Which of the following are possible outputs of the increment process? To answer: Fill in A for possible, B for not possible.

6. 012345678 ...
7. 012301234 ...
8. 012345670123 ...
9. 01234567891011 ...
10. 123456789 ...

```json
{
  "problem_id": "2",
  "points": 1,
  "type": "Freeform",
  "tags": ["concurrency","memory-model"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 3 [5 point(s)]

Problem III: A concurrent program (with multiple threads) looks like this:
```c
volatile int counter = 1000;
void *worker(void *arg) {
  counter--;
  return NULL;
}
int main(int argc, char *argv[]) {
  pthread_t p1, p2;
  pthread_create(&p1, NULL, worker, NULL);
  pthread_create(&p2, NULL, worker, NULL);
  pthread_join(p1, NULL);
  pthread_join(p2, NULL);
  printf(\"%d\\n\", counter);
  return 0;
}
```
Assuming pthread_create() and pthread_join() work as expected, which outputs are possible? To answer: Fill in A for possible, B for not possible.

11. 0
12. 1000
13. 999
14. 998
15. 1002

```json
{
  "problem_id": "3",
  "points": 1,
  "type": "Freeform",
  "tags": ["concurrency","threads"],
  "answer": "B",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'B'. Award 0 points otherwise."
}
```

---

## Question 4 [4 point(s)]

Problem IV: Processes exist in a number of different states (Running, Ready, Blocked, etc.). Assuming you start observing the states of a given process at some point in time (not necessarily from its creation), which process state sequences could you possibly observe? Note: once you start observing the process, you will see ALL states it is in, until you stop sampling. To answer: Fill in A for possible, B for not possible.

16. Running, Running, Running, Ready, Running, Running, Running, Ready
17. Embryo, Ready, Ready, Ready, Ready, Ready
18. Running, Running, Blocked, Blocked, Blocked, Running
19. Running, Running, Blocked, Blocked, Blocked, Ready, Running
20. Embryo, Running, Blocked, Running, Zombie, Running

```json
{
  "problem_id": "4",
  "points": 1,
  "type": "Freeform",
  "tags": ["os","process-states"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 5 [5 point(s)]

Problem V: The following code is shown to you:
```c
int main(int argc, char *argv[]) {
  printf(\"a\");
  fork();
  printf(\"b\");
  return 0;
}
```
Assuming fork() succeeds and printf() prints its outputs immediately (no buffering occurs), what are possible outputs of this program? To answer: Fill in A for possible, B for not possible.

21. ab
22. abb
23. bab
24. bba
25. a

```json
{
  "problem_id": "5",
  "points": 1,
  "type": "Freeform",
  "tags": ["processes","fork"],
  "answer": "B",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'B'. Award 0 points otherwise."
}
```

---

## Question 6 [5 point(s)]

Problem VI: Assuming fork() might fail (by returning an error code and not creating a new process) and printf() prints its outputs immediately (no buffering occurs), what are possible outputs of the same program as above? To answer: Fill in A for possible, B for not possible.

26. ab
27. abb
28. bab
29. bba
30. a

```json
{
  "problem_id": "6",
  "points": 1,
  "type": "Freeform",
  "tags": ["processes","fork"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 7 [5 point(s)]

Problem VII: Here is code. Assume the program /bin/true, when it runs, never prints anything and just returns 0.
```c
int main(int argc, char *argv[]) {
  int rc = fork();
  if (rc == 0) {
    char *my_argv[] = { \"/bin/true\", NULL };
    execv(my_argv[0], my_argv);
    printf(\"1\");
  } else if (rc > 0) {
    wait(NULL);
    printf(\"2\");
  } else {
    printf(\"3\");
  }
  return 0;
}
```
Assuming all system calls succeed and printf() prints its outputs immediately (no buffering occurs), what outputs are possible? To answer: Fill in A for possible, B for not possible.

31. 123
32. 12
33. 2
34. 23
35. 3

```json
{
  "problem_id": "7",
  "points": 1,
  "type": "Freeform",
  "tags": ["processes","fork","exec"],
  "answer": "B",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'B'. Award 0 points otherwise."
}
```

---

## Question 8 [5 point(s)]

Problem VIII: Same code snippet as in the last problem, but new question: assuming any of the system calls above might fail (by returning an error code), what outputs are possible? Assume printf() prints its outputs immediately. To answer: Fill in A for possible, B for not possible.

36. 123
37. 12
38. 2
39. 23
40. 3

```json
{
  "problem_id": "8",
  "points": 1,
  "type": "Freeform",
  "tags": ["processes","fork","exec"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 9 [5 point(s)]

Problem IX: Assume, for the following jobs, a FIFO scheduler and only one CPU. Each job has a required runtime.
Job A arrives at time=0, required runtime=X
Job B arrives at time=5, required runtime=Y
Job C arrives at time=10, required runtime=Z
Assuming an average turnaround time between 10 and 20 time units (inclusive), which of the following run times for A, B, and C are possible? To answer: Fill in A for possible, B for not possible.

41. A=10, B=10, C=10
42. A=20, B=20, C=20
43. A=5, B=10, C=15
44. A=20, B=30, C=40
45. A=30, B=1, C=1

```json
{
  "problem_id": "9",
  "points": 1,
  "type": "Freeform",
  "tags": ["scheduling","fifo"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 10 [5 point(s)]

Problem X: Assume the following schedule for jobs A, B, and C:
- A runs first (for 10 time units) but is not yet done
- B runs next (for 10 time units) but is not yet done
- C runs next (for 10 time units) and runs to completion
- A runs to completion (for 10 time units)
- B runs to completion (for 5 time units)
Which scheduling disciplines could allow this schedule to occur? To answer: Fill in A for possible, B for not possible.

46. FIFO
47. Round Robin
48. STCF (Shortest Time to Completion First)
49. Multi-level Feedback Queue
50. Lottery Scheduling

```json
{
  "problem_id": "10",
  "points": 1,
  "type": "Freeform",
  "tags": ["scheduling","mlfq","rr"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 11 [5 point(s)]

Problem XI: The Multi-level Feedback Queue (MLFQ) is a scheduler. Which of the following are true statements about MLFQ? To answer: Fill in A for true, B for not true.

51. MLFQ learns things about running jobs
52. MLFQ starves long running jobs
53. MLFQ uses different length time slices for jobs
54. MLFQ uses round robin
55. MLFQ forgets what it has learned about running jobs sometimes

```json
{
  "problem_id": "11",
  "points": 1,
  "type": "Freeform",
  "tags": ["scheduling","mlfq"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 12 [5 point(s)]

Problem XII: The simplest technique for virtualizing memory is base-and-bounds. Assuming:
- 1KB virtual address space
- base register = 10000
- bounds register = 100
Which of the following physical memory locations can be legally accessed by the running program? To answer: Fill in A for legally accessible, B for not legally accessible.

56. 0
57. 1000
58. 10000
59. 10050
60. 10100

```json
{
  "problem_id": "12",
  "points": 1,
  "type": "Freeform",
  "tags": ["virtual-memory","base-bounds"],
  "answer": "B",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'B'. Award 0 points otherwise."
}
```

---

## Question 13 [5 point(s)]

Problem XIII: Assuming the same set-up as above (1 KB virtual address space, base=10000, bounds=100), which of the following virtual addresses can be legally accessed by the running program? To answer: Fill in A for valid virtual addresses, B for not valid ones.

61. 0
62. 1000
63. 10000
64. 10050
65. 10100

```json
{
  "problem_id": "13",
  "points": 1,
  "type": "Freeform",
  "tags": ["virtual-memory","segmentation"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 14 [5 point(s)]

Problem XIV: Segmentation is a generalization of base-and-bounds. Which possible advantages does segmentation have as compared to base-and-bounds? To answer: Fill in A for true, B for not true.

66. Faster translation
67. Less physical memory waste
68. Better sharing of code in memory
69. More hardware support needed to implement it
70. More OS issues to handle, such as compaction

```json
{
  "problem_id": "14",
  "points": 1,
  "type": "Freeform",
  "tags": ["segmentation","memory-management"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 15 [5 point(s)]

Problem XV: Assume a segmentation system with two segments (code/heap grows positive, stack grows negative):
- Virtual address space size 128 bytes
- Physical memory size 512 bytes
Segment registers:
Segment 0 base (grows positive): 0
Segment 0 limit: 20 (decimal)
Segment 1 base (grows negative): 0x200 (decimal 512)
Segment 1 limit: 20 (decimal)
Which of the following are valid virtual memory accesses? To answer: Fill in A for valid, B for not valid.

71. 0x1d (decimal: 29)
72. 0x7b (decimal: 123)
73. 0x10 (decimal: 16)
74. 0x5a (decimal: 90)
75. 0x0a (decimal: 10)

```json
{
  "problem_id": "15",
  "points": 1,
  "type": "Freeform",
  "tags": ["segmentation","virtual-memory"],
  "answer": "B",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'B'. Award 0 points otherwise."
}
```

---

## Question 16 [5 point(s)]

Problem XVI: In a simple page-based virtual memory, with a linear page table, assume:
- virtual address space: 128 bytes
- physical memory: 1024 bytes
- page size: 16 bytes
Page table entries (high-order bit is VALID):
[0]   0x80000034
[1]   0x00000000
[2]   0x00000000
[3]   0x00000000
[4]   0x8000001e
[5]   0x80000017
[6]   0x80000011
[7]   0x8000002e
Which of the following virtual addresses are valid? To answer: Fill in A for valid, B for not valid.

76. 0x34 (decimal: 52)
77. 0x44 (decimal: 68)
78. 0x57 (decimal: 87)
79. 0x18 (decimal: 24)
80. 0x46 (decimal: 70)

```json
{
  "problem_id": "16",
  "points": 1,
  "type": "Freeform",
  "tags": ["virtual-memory","tlb"],
  "answer": "B",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'B'. Award 0 points otherwise."
}
```

---

## Question 17 [5 point(s)]

Problem XVII: TLBs: Assume:
- page size = 64 bytes
- TLB contains 4 entries
- replacement policy = LRU
Each of the following is a virtual address trace. In which traces will the TLB possibly help speed up execution? To answer: Fill in A for helps, B for does not help.

81. 0, 100, 200, 1, 101, 201, ... (repeats)
82. 0, 100, 200, 300, 0, 100, 200, 300, ... (repeats)
83. 0, 1000, 2000, 3000, 4000, 0, 1000, 2000, 3000, 4000, ... (repeats)
84. 0, 1, 2, 3, 4, 5, 6, 0, 1, 2, 3, 4, 5, 6, ... (repeats)
85. 300, 200, 100, 0, 300, 200, 100, 0, ... (repeats)

```json
{
  "problem_id": "17",
  "points": 1,
  "type": "Freeform",
  "tags": ["paging","tlb"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 18 [5 point(s)]

Problem XVIII: Which of the following statements are true about page-replacement policies? To answer: Fill in A for true, B for false.

86. The LRU policy always outperforms the FIFO policy.
87. The OPT (optimal) policy always performs at least as well as LRU.
88. A bigger cache’s hit percentage is always greater than or equal to a smaller cache’s hit percentage, if they use the same replacement policy.
89. A bigger cache’s hit percentage is always greater than or equal to a smaller cache’s hit percentage, if they are using the LRU replacement policy.
90. Random replacement is always worse than LRU replacement.

```json
{
  "problem_id": "18",
  "points": 1,
  "type": "Freeform",
  "tags": ["paging","replacement-policies"],
  "answer": "B",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'B'. Award 0 points otherwise."
}
```

---

## Question 19 [5 point(s)]

Problem XIX: Assume a memory that can hold 4 pages, LRU replacement. The first four references are pages 6, 7, 7, 9. The next five accesses are to pages 7, 9, 0, 4, 9. Which of those will hit in memory? To answer: Fill in A for hits, B for misses.

91. 7
92. 9
93. 0
94. 4
95. 9

```json
{
  "problem_id": "19",
  "points": 1,
  "type": "Freeform",
  "tags": ["paging","cache"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 20 [5 point(s)]

Problem XX: Assume this attempted implementation of a lock:
void init(lock_t *mutex) {
  mutex->flag = 0;  // 0 -> lock is available, 1 -> held
}
void lock(lock_t *mutex) {
  while (mutex->flag == 1) // L1
    ;                      // L2
  mutex->flag = 1;         // L3
}
void unlock(lock_t *mutex) {
  mutex->flag = 0;         // L4
}
Assume 5 threads are competing for this lock. How many threads can possibly acquire the lock? To answer: Fill in A for possible, B for not possible.

96. 1
97. 2
98. 3
99. 4
100. 5

```json
{
  "problem_id": "20",
  "points": 1,
  "type": "Freeform",
  "tags": ["concurrency","locking"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 21 [5 point(s)]

Problem XXI: Ticket lock:
typedef struct __lock_t { int ticket, turn; } lock_t;
void lock_init(lock_t *lock) { lock->ticket = 0; lock->turn = 0; }
void lock(lock_t *lock) {
  int myturn = FetchAndAdd(&lock->ticket);
  while (lock->turn != myturn) ; // spin
}
void unlock(lock_t *lock) { lock->turn = lock->turn + 1; }
Assuming a maximum of 5 threads and proper use of the lock, what values of lock->ticket and lock->turn are possible at the same time? To answer: Fill in A for possible, B for not possible.

101. ticket=0 and turn=0
102. ticket=0 and turn=1
103. ticket=1 and turn=0
104. ticket=16 and turn=5
105. ticket=1000 and turn=999

```json
{
  "problem_id": "21",
  "points": 1,
  "type": "Freeform",
  "tags": ["synchronization","ticket-lock"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 22 [5 point(s)]

Problem XXII: List insertion code (no synchronization):
int List_Insert(int key) {
  node_t *n = malloc(sizeof(node_t));
  if (n == NULL) { return -1; }
  n->key = key;
  n->next = head;
  head = n;
  return 0;
}
Executed by three threads exactly once each, malloc() is thread-safe and succeeds. How long might the list be when finished (list was empty to begin)? To answer: Fill in A for possible, B for not possible.

106. 0
107. 1
108. 2
109. 3
110. 4

```json
{
  "problem_id": "22",
  "points": 1,
  "type": "Freeform",
  "tags": ["concurrency","data-structure"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 23 [5 point(s)]

Problem XXIII: Background malloc code with races. Assume pthread_create() and calloc() succeed, and NULL pointer dereference crashes reliably. What are the possible outcomes? To answer: Fill in A if possible, B for not possible.

111. The code prints out 0
112. The code prints out 10
113. The code prints out 100
114. The code crashes
115. The code hangs forever

```json
{
  "problem_id": "23",
  "points": 1,
  "type": "Freeform",
  "tags": ["threads","memory-allocation","race"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 24 [5 point(s)]

Problem XXIV: Multi-threaded printer code where each thread is given a malloc'd char containing 'a' + i. Assuming library calls succeed, which outputs are possible? To answer: Fill in A if possible, B for not possible.

116. abcde
117. edcba
118. cccde
119. eeeee
120. aaaaa

```json
{
  "problem_id": "24",
  "points": 1,
  "type": "Freeform",
  "tags": ["threads","printing"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 25 [5 point(s)]

Problem XXV: Same printer() but threads are given the address of a stack variable 'c' that changes. Assuming library calls succeed, which outputs are possible? To answer: Fill in A if possible, B for not possible.

121. abcde
122. edcba
123. cccde
124. eeeee
125. aaaaa

```json
{
  "problem_id": "25",
  "points": 1,
  "type": "Freeform",
  "tags": ["threads","race"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 26 [5 point(s)]

Problem XXVI: Threaded allocator sketch:
int bytes_left = MAX_HEAP_SIZE;
pthread_cond_t c;
pthread_mutex_t m;
void *allocate(int size) {
  pthread_mutex_lock(&m);
  while (bytes_left < size)
    pthread_cond_wait(&c, &m);
  void *ptr = ...;
  bytes_left -= size;
  pthread_mutex_unlock(&m);
  return ptr;
}
void free(void *ptr, int size) {
  pthread_mutex_lock(&m);
  bytes_left += size;
  pthread_cond_signal(&c);
  pthread_mutex_unlock(&m);
}
Assume bytes_left is 0. Then T1 calls allocate(100), later T2 calls allocate(1000), later T3 calls free(200). Which of the following are possible just after this sequence? To answer: Fill in A if possible, B for not possible.

126. T1 and T2 remain blocked inside allocate()
127. T1 becomes unblocked, gets 100 bytes allocated, and returns from allocate()
128. T2 becomes unblocked, gets 1000 bytes allocated, and returns from allocate()
129. T3 becomes blocked inside free()
130. T1, T2, and T3 become deadlocked

```json
{
  "problem_id": "26",
  "points": 1,
  "type": "Freeform",
  "tags": ["memory-allocation","threads"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 27 [5 point(s)]

Problem XXVII: Which statements are true about semaphores? To answer: Fill in A if true, B if not true.

131. Each semaphore has an integer value
132. If a semaphore is initialized to 1, it can be used as a lock
133. Semaphores can be initialized to values higher than 1
134. A single lock and condition variable can be used in tandem to implement a semaphore
135. Calling sem_post() may block, depending on the current value of the semaphore

```json
{
  "problem_id": "27",
  "points": 1,
  "type": "Freeform",
  "tags": ["semaphores"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 28 [5 point(s)]

Problem XXVIII: Semaphore producer/consumer:
producer:
for (i = 0; i < num; i++) {
  sem_wait(&empty);
  sem_wait(&mutex);
  put(i);
  sem_post(&mutex);
  sem_post(&full);
}
consumer:
while (!done) {
  sem_wait(&full);
  sem_wait(&mutex);
  int tmp = get(i);
  sem_post(&mutex);
  sem_post(&empty);
  // use tmp ...
}
Which statements about initializations are true? To answer: Fill in A if true, B if not true.

136. The semaphore full must be initialized to 0
137. The semaphore full must be initialized to 1
138. The semaphore empty must be initialized to 1
139. The semaphore empty can be initialized to 1
140. The semaphore mutex must be initialized to 1

```json
{
  "problem_id": "28",
  "points": 1,
  "type": "Freeform",
  "tags": ["semaphores","producer-consumer"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 29 [5 point(s)]

Problem XXIX: Avoiding deadlock by scheduling. Threads:
- T1 acquires/releases L1, L2
- T2 acquires/releases L1, L3
- T3 acquires/releases L3, L1, and L4
For which schedules is deadlock possible? To answer: Fill in A if deadlock is possible, B if not.

141. T1 runs to completion, then T2 to completion, then T3 runs
142. T1 and T2 run concurrently to completion, then T3 runs
143. T1, T2, and T3 run concurrently
144. T3 runs to completion, then T1 and T2 run concurrently
145. T1 and T3 run concurrently to completion, then T2 runs

```json
{
  "problem_id": "29",
  "points": 1,
  "type": "Freeform",
  "tags": ["concurrency","deadlock"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```

---

## Question 30 [5 point(s)]

Problem XXX: Multi-level page table true/false. To answer: Fill in A if true, B if not true.

146. A multi-level page table may use more pages than a linear page table
147. It’s easier to allocate pages of the page table in a multi-level table (as compared to a linear page table)
148. Multi-level page table lookups take longer than linear page table lookups
149. With larger virtual address spaces, usually more levels are used
150. TLBs are useful in making multi-level page tables even smaller

```json
{
  "problem_id": "30",
  "points": 1,
  "type": "Freeform",
  "tags": ["paging","page-tables"],
  "answer": "A",
  "llm_judge_instructions": "Award 1 point if the student's answer equals 'A'. Award 0 points otherwise."
}
```
