# CS 537 Spring 2018 Midterm

```json
{
  "exam_id": "cs537_spring_2018_midterm",
  "test_paper_name": "CS 537 Spring 2018 Midterm",
  "course": "CS 537",
  "institution": "Unknown",
  "year": 2018,
  "score_total": 30,
  "num_questions": 30
}
```

---

## Question 1 [1 point]

Problem I:A program’s main function is as follows:
int main(int argc, char
*
argv[]) {
char
*
str = argv[1];
while (1)
printf("%s", str);
return 0;
}
Two processes, both running instances of this program, are currently running (you can assume nothing
else of relevance is, except perhaps the shell itself). The programs were invoked as follows, assuming a
“parallel command” as per project 2a (the wish shell):
wish> main a && main b
Below are possible (or impossible?) screen captures of someof the output from the beginning of the run
of the programs. Which of the following are possible?To answer:Fill inAfor possible,Bfor not possible.
1. abababab ...
A. Possible
2. aaaaaaaa ...
A. Possible
3. bbbbbbbb ...
A. Possible
4. aaaabbbb ...
A. Possible
5. bbbbaaaa ...
A. Possible

```json
{
  "problem_id": "1",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["concurrency","processes","interleaving-output"],
  "choices": [
    "abababab ...",
    "aaaaaaaa ...",
    "bbbbbbbb ...",
    "aaaabbbb ...",
    "bbbbaaaa ..."
  ],
  "answer": "A"
}
```

---

## Question 2 [1 point]

Problem II:Here is source code for another program, calledincrement.c:
int value = 0;
int main(int argc, char
*
argv[]) {
while (1) {
printf("%d", value);
value++;
}
return 0;
}
While increment.c is running, another program,reset.c, is run once as a separate process. Here is the
source code ofreset.c:
int value;
int main(int argc, char
*
argv[]) {
value = 0;
return 0;
}
Which of the following are possible outputs of the increment process?
To answer:Fill inAfor possible,Bfor not possible.
6. 012345678 ...A. Possible
7. 012301234 ...B. Not Possible(value is reset, but how?)
8. 012345670123 ...B. Not Possible(value is reset, but how?)
9. 01234567891011 ...A. Possible(value not reset; it’s just “9 10 11” squished together)
10. 123456789 ...B. Not Possible(increment starts at 0)

```json
{
  "problem_id": "2",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["concurrency","race-condition","shared-memory"],
  "choices": [
    "012345678 ...",
    "012301234 ...",
    "012345670123 ...",
    "01234567891011 ...",
    "123456789 ..."
  ],
  "answer": "A"
}
```

---

## Question 3 [1 point]

Problem III:A concurrent program (with multiple threads) looks like this:
volatile int counter = 1000;
void
*
worker(void
*
arg) {
counter--;
return NULL;
}
int main(int argc, char
*
argv[]) {
pthread_t p1, p2;
pthread_create(&p1, NULL, worker, NULL);
pthread_create(&p2, NULL, worker, NULL);
pthread_join(p1, NULL);
pthread_join(p2, NULL);
printf("%d\n", counter);
return 0;
}
Assumingpthread
create()andpthreadjoin()all work as expected (i.e., they don’t return an error), which outputs are possible?
To answer:Fill inAfor possible,Bfor not possible.
11. 0
A. Possible
12. 1000
B. Not Possible
13. 999
A. Possible
14. 998
A. Possible
15. 1002
B. Not Possible

```json
{
  "problem_id": "3",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["concurrency","race-condition","threads"],
  "choices": [
    "0",
    "1000",
    "999",
    "998",
    "1002"
  ],
  "answer": "A"
}
```

---

## Question 4 [1 point]

Problem IV:Processes exist in a number of different states. We’ve focused upon a few (Running, Ready,
and Blocked) but real systems have slightly more. For example, xv6 also has an Embryo state (used when
the process is being created), and a Zombie state (used when the process has exited but its parent hasn’t yet
called wait() on it).
Assuming you start observing the states of a given process atsome point in time (not necessarily from
its creation, but perhaps including that), which process states could you possibly observe?
Note: once you start observing the process, you will see ALL states it is in, until you stop sampling.
To answer:Fill inAfor possible,Bfor not possible.
16. Running, Running, Running, Ready, Running, Running, Running, Ready
A. Possible
17. Embryo, Ready, Ready, Ready, Ready, Ready
A. Possible
18. Running, Running, Blocked, Blocked, Blocked, Running
B. Not Possible
19. Running, Running, Blocked, Blocked, Blocked, Ready, Running
A. Possible
20. Embryo, Running, Blocked, Running, Zombie, Running
B. Not Possible

```json
{
  "problem_id": "4",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["process-states","xv6","scheduling"],
  "choices": [
    "Running, Running, Running, Ready, Running, Running, Running, Ready",
    "Embryo, Ready, Ready, Ready, Ready, Ready",
    "Running, Running, Blocked, Blocked, Blocked, Running",
    "Running, Running, Blocked, Blocked, Blocked, Ready, Running",
    "Embryo, Running, Blocked, Running, Zombie, Running"
  ],
  "answer": "A"
}
```

---

## Question 5 [1 point]

Problem V:The following code is shown to you:
int main(int argc, char
*
argv[]) {
printf("a");
fork();
printf("b");
return 0;
}
Assuming fork() succeeds andprintf()prints its outputs immediately (no buffering occurs), whatare
possible outputs of this program?
To answer:Fill inAfor possible,Bfor not possible.
21. ab
B. Not Possible
22. abb
A. Possible
23. bab
B. Not Possible
24. bba
B. Not Possible
25. a
B. Not Possible

```json
{
  "problem_id": "5",
  "points": 1,
  "type": "ExactMatch",
 "tags": ["fork","output-order","processes"],
  "choices": [
    "ab",
    "abb",
    "bab",
    "bba",
    "a"
  ],
  "answer": "A"
}
```

---

## Question 6 [1 point]

Problem VI:Assumingfork()might fail (by returning an error code and not creating a new process)
andprintf()prints its outputs immediately (no buffering occurs), whatare possible outputs of the same
program as above?
To answer:Fill inAfor possible,Bfor not possible.
26. ab
A. Possible
27. abb
A. Possible
28. bab
B. Not Possible
29. bba
B. Not Possible
30. a
B. Not Possible

```json
{
  "problem_id": "6",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["fork","error-handling","processes"],
  "choices": [
    "ab",
    "abb",
    "bab",
    "bba",
    "a"
  ],
  "answer": "A"
}
```

---

## Question 7 [1 point]

Problem VII:Here is even more code to look at. Assume the program/bin/true, when it runs, never
prints anything and just returns 0 in all cases.
int main(int argc, char
*
argv[]) {
int rc = fork();
if (rc == 0) {
char
*
my_argv[] = { "/bin/true", NULL };
execv(my_argv[0], my_argv);
printf("1");
} else if (rc > 0) {
wait(NULL);
printf("2");
} else {
printf("3");
}
return 0;
}
Assuming all system calls succeed andprintf()prints its outputs immediately (no buffering occurs),
what outputs are possible?
To answer:Fill inAfor possible,Bfor not possible.
31. 123
B. Not Possible
32. 12
B. Not Possible
33. 2
A. Possible
34. 23
B. Not Possible
35. 3
B. Not Possible

```json
{
  "problem_id": "7",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["fork","exec","processes"],
  "choices": [
    "123",
    "12",
    "2",
    "23",
    "3"
  ],
  "answer": "A"
}
```

---

## Question 8 [1 point]

Problem VIII:Same code snippet as in the last problem, but new question: assuming any of the system calls
above might fail (by not doing what is expected, and returning an error code), what outputs are possible?
Again assume thatprintf()prints its outputs immediately (no buffering occurs).
To answer:Fill inAfor possible,Bfor not possible.
36. 123
A. Possible
37. 12
A. Possible
38. 2
A. Possible
39. 23
B. Not Possible
40. 3
A. Possible

```json
{
  "problem_id": "8",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["fork","exec","error-handling"],
  "choices": [
    "123",
    "12",
    "2",
    "23",
    "3"
  ],
  "answer": "A"
}
```

---

## Question 9 [1 point]

Problem IX:Assume, for the following jobs, a FIFO scheduler and only oneCPU. Each job has a “required”
runtime, which means the job needs that many time units on theCPU to complete.
Job A arrives at time=0, required runtime=X time units
Job B arrives at time=5, required runtime=Y time units
Job C arrives at time=10, required runtime=Z time units
Assuming anaverage turnaround timebetween 10 and 20 time units (inclusive), which of the following
run times for A, B, and C are possible?
To answer:Fill inAfor possible,Bfor not possible.
41. A=10, B=10, C=10
A. Possible
42. A=20, B=20, C=20
B. Not Possible
43. A=5, B=10, C=15
A. Possible
44. A=20, B=30, C=40
B. Not Possible
45. A=30, B=1, C=1
B. Not Possible

```json
{
  "problem_id": "9",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["scheduling","FIFO","turnaround"],
  "choices": [
    "A=10, B=10, C=10",
    "A=20, B=20, C=20",
    "A=5, B=10, C=15",
    "A=20, B=30, C=40",
    "A=30, B=1, C=1"
  ],
  "answer": "A"
}
```

---

## Question 10 [1 point]

Problem X:Assume the following schedule for a set of three jobs, A, B, and C:
A runs first (for 10 time units) but is not yet done
B runs next (for 10 time units) but is not yet done
C runs next (for 10 time units) and runs to completion
A runs to completion (for 10 time units)
B runs to completion (for 5 time units)
Which scheduling disciplines could allow this schedule to occur?
To answer:Fill inAfor possible,Bfor not possible.
46. FIFO
B. Not Possible
47. Round Robin
A. Possible
48. STCF (Shortest Time to Completion First)
B. Not Possible
49. Multi-level Feedback Queue
A. Possible
50. Lottery Scheduling
A. Possible

```json
{
  "problem_id": "10",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["scheduling","RR","MLFQ","FIFO","lottery"],
  "choices": [
    "FIFO",
    "Round Robin",
    "STCF (Shortest Time to Completion First)",
    "Multi-level Feedback Queue",
    "Lottery Scheduling"
  ],
  "answer": "A"
}
```

---

## Question 11 [1 point]

Problem XI:The Multi-level Feedback Queue (MLFQ) is a fancy scheduler that does lots of things. Which
of the following things could you possibly say (correctly!)about the MLFQ approach?
To answer:Fill inAfor things that are true about MLFQ,Bfor things that are not true about MLFQ.
51. MLFQ learns things about running jobs
A. Possible/True
By moving jobs down queues, it learns that
they are long running (for example).
52. MLFQ starves long running jobs
B. Not Possible/False
By bumping priority on occasion, MLFQ
avoids starvation.
53. MLFQ uses different length time slices for jobs
A. PossibleTrue, sometimes, across different queues.
54. MLFQ uses round robin
A. PossibleTrue, within a given level.
55. MLFQ forgets what it has learned about running jobs sometimes
A. PossibleTrue, with priority bump to top priority, all jobs look the same now, and all is forgotten about them.

```json
{
  "problem_id": "11",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["scheduling","MLFQ"],
  "choices": [
    "MLFQ learns things about running jobs",
    "MLFQ starves long running jobs",
    "MLFQ uses different length time slices for jobs",
    "MLFQ uses round robin",
    "MLFQ forgets what it has learned about running jobs sometimes"
  ],
  "answer": "A"
}
```

---

## Question 12 [1 point]

Problem XII:The simplest technique for virtualizing memory is known as dynamic relocation, or “base-
and-bounds”. Assuming the following system characteristics:
- a 1KB virtual address space
- a base register set to 10000
- a bounds register set to 100
Which of the followingphysical memory locationscan be legally accessed by the running program?
To answer:Fill inAfor legally accessible locations,Bfor locations not legally accessible by this program.
56. 0
B. Not Possible
57. 1000
B. Not Possible
58. 10000
A. Possible
59. 10050
A. Possible
60. 10100
B. Not Possible

```json
{
  "problem_id": "12",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["virtual-memory","base-and-bounds"],
  "choices": [
    "0",
    "1000",
    "10000",
    "10050",
    "10100"
  ],
  "answer": "B"
}
```

---

## Question 13 [1 point]

Problem XIII:Assuming the same set-up as above (1 KB virtual address space, base=10000, bounds=100),
which of the followingvirtual addressescan be legally accessed by the running program? (i.e., whichare
valid?)
To answer:Fill inAfor valid virtual addresses,Bfor not valid ones.
61. 0
A. Possible
62. 1000
B. Not Possible
63. 10000
B. Not Possible
64. 10050
B. Not Possible
65. 10100
B. Not Possible

```json
{
  "problem_id": "13",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["virtual-memory","address-space"],
  "choices": [
    "0",
    "1000",
    "10000",
    "10050",
    "10100"
  ],
  "answer": "A"
}
```

---

## Question 14 [1 point]

Problem XIV:Segmentation is a generalization of base-and-bounds. Whichpossible advantages does seg-
mentation have as compared to base-and-bounds?
To answer:Fill inAfor cases where the statement is true about segmentation and(as a result) segmentation
has a clear advantage over base-and-bounds,Botherwise.
66. Faster translation
B. Not Possible
67. Less physical memory waste
A. Possible
68. Better sharing of code in memory
A. Possible
69. More hardware support needed to implement it
B. Not Possible
70. More OS issues to handle, such as compaction
B. Not Possible

```json
{
  "problem_id": "14",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["segmentation","baselined-memory"],
  "choices": [
    "Faster translation",
    "Less physical memory waste",
    "Better sharing of code in memory",
    "More hardware support needed to implement it",
    "More OS issues to handle, such as compaction"
  ],
  "answer": "A"
}
```

---

## Question 15 [1 point]

Problem XV:Assume the following in a simple segmentation system that supportstwosegments: one
(positive growing) for code and a heap, and one (negative growing) for a stack:
- Virtual address space size 128 bytes (small!)
- Physical memory size 512 (small!)
Segment register information:
Segment 0 base  (grows positive) : 0
Segment 0 limit                  : 20 (decimal)
Segment 1 base  (grows negative) : 0x200 (decimal 512)
Segment 1 limit                  : 20 (decimal)
Which of the following arevalidvirtual memory accesses?
To answer:Fill inAfor valid virtual accesses,Bfor non-valid accesses.
71. 0x1d (decimal: 29)
B. Not Possible
72. 0x7b (decimal: 123)
A. Possible
73. 0x10 (decimal: 16)
A. Possible
74. 0x5a (decimal: 90)
B. Not Possible
75. 0x0a (decimal: 10)
A. Possible

```json
{
  "problem_id": "15",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["segmentation","virtual-memory"],
  "choices": [
    "0x1d (decimal: 29)",
    "0x7b (decimal: 123)",
    "0x10 (decimal: 16)",
    "0x5a (decimal: 90)",
    "0x0a (decimal: 10)"
  ],
  "answer": "A"
}
```

---

## Question 16 [1 point]

Problem XVI:In a simple page-based virtual memory, with a linear page table, assume the following:
- virtual address space size is 128 bytes (small!)
- physical memory size of 1024 bytes (small!)
- page size of 16 bytes
The format of the page table: The high-order (leftmost) bit is the VALID bit.
If the bit is 1, the rest of the entry is the PFN.
If the bit is 0, the page is not valid.
Here are the contents of the page table (from entry 0 down to the max size)
[0]   0x80000034
[1]   0x00000000
[2]   0x00000000
[3]   0x00000000
[4]   0x8000001e
[5]   0x80000017
[6]   0x80000011
[7]   0x8000002e
Which of the following virtual addresses arevalid?
To answer:Fill inAfor valid virtual accesses,Bfor non-valid accesses.
From the page table, we can identify valid pages 0,4,5,6,7. VPN is the top 3 bits of a 7-bit VA (128B) with 4-bit offset.
76. 0x34 (decimal: 52)
B. Not ValidVPN=3
77. 0x44 (decimal: 68)
A. ValidVPN=4
78. 0x57 (decimal: 87)
A. ValidVPN=5
79. 0x18 (decimal: 24)
B. Not ValidVPN=1
80. 0x46 (decimal: 70)
A. ValidVPN=4

```json
{
  "problem_id": "16",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["paging","page-table","virtual-memory"],
  "choices": [
    "0x34 (decimal: 52)",
    "0x44 (decimal: 68)",
    "0x57 (decimal: 87)",
    "0x18 (decimal: 24)",
    "0x46 (decimal: 70)"
  ],
  "answer": "A"
}
```

---

## Question 17 [1 point]

Problem XVII:TLBs are a critical part of modern paging systems. Assume thefollowing system:
- page size is 64 bytes
- TLB contains 4 entries
- TLB replacement policy is LRU (least recently used)
Each of the following represents a virtual memory address trace, i.e., a set of virtual memory addresses
referenced by a program. In which of the following traces will the TLB possibly help speed up execution?
To answer:Fill inAfor cases where the TLB will speed up the program,Bfor the cases where it won’t.
81. 0, 100, 200, 1, 101, 201, ... (repeats in this pattern)
A. Speed up
82. 0, 100, 200, 300, 0, 100, 200, 300, ... (repeats)
A. Speed up
83. 0, 1000, 2000, 3000, 4000, 0, 1000, 2000, 3000, 4000, ... (repeats)
B. No Speedup
84. 0, 1, 2, 3, 4, 5, 6, 0, 1, 2, 3, 4, 5, 6, ... (repeats)
A. Speed up
85. 300, 200, 100, 0, 300, 200, 100, 0, ... (repeats)
A. Speed up

```json
{
  "problem_id": "17",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["TLB","paging","memory"],
  "choices": [
    "0, 100, 200, 1, 101, 201, ... (repeats in this pattern)",
    "0, 100, 200, 300, 0, 100, 200, 300, ... (repeats)",
    "0, 1000, 2000, 3000, 4000, 0, 1000, 2000, 3000, 4000, ... (repeats)",
    "0, 1, 2, 3, 4, 5, 6, 0, 1, 2, 3, 4, 5, 6, ... (repeats)",
    "300, 200, 100, 0, 300, 200, 100, 0, ... (repeats)"
  ],
  "answer": "A"
}
```

---

## Question 18 [1 point]

Problem XVIII:Which of the following statements are true statements about various page-replacement
policies?
To answer:Fill inAfor true statements,Bfor false ones.
86. The LRU policy always outperforms the FIFO policy.
B. False
87. The OPT (optimal) policy always performs at least as wellas LRU.
A. True
88. A bigger cache’s hit percentage is always greater than orequal to a smaller cache’s hit percentage, if
they are using the same replacement policy.
B. False
89. A bigger cache’s hit percentage is always greater than orequal to a smaller cache’s hit percentage,
if they are using the LRU replacement policy.
A. True
90. Random replacement is always worse than LRU replacement.
B. False

```json
{
  "problem_id": "18",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["page-replacement","LRU","FIFO","OPT"],
  "choices": [
    "The LRU policy always outperforms the FIFO policy.",
    "The OPT (optimal) policy always performs at least as wellas LRU.",
    "A bigger cache’s hit percentage is always greater than orequal to a smaller cache’s hit percentage, if they are using the same replacement policy.",
    "A bigger cache’s hit percentage is always greater than orequal to a smaller cache’s hit percentage, if they are using the LRU replacement policy.",
    "Random replacement is always worse than LRU replacement."
  ],
  "answer": "B"
}
```

---

## Question 19 [1 point]

Problem XIX:Assume a memory that can hold 4 pages, and an LRU replacement policy. The first four
references to memory are to pages 6, 7, 7, 9.
Assuming the next five accesses are to pages 7, 9, 0, 4, 9, whichof those will hit in memory? (and which
will miss?)
To answer:Fill inAfor cache hits,Bfor misses.
91. 7
A. Hit
92. 9
A. Hit
93. 0
B. Miss
94. 4
B. Miss
95. 9
A. Hit

```json
{
  "problem_id": "19",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["cache","LRU","memory"],
  "choices": [
    "7",
    "9",
    "0",
    "4",
    "9"
  ],
  "answer": "A"
}
```

---

## Question 20 [1 point]

Problem XX:Assume this attempted implementation of a lock:
void init(lock_t
*
mutex) {
mutex->flag = 0;  // 0 -> lock is available, 1 -> held
}
void lock(lock_t
*
mutex) {
while (mutex->flag == 1) // L1
;                      // L2
mutex->flag = 1;         // L3
}
void unlock(lock_t
*
mutex) {
mutex->flag = 0;         // L4
}
Assume 5 threads are competing for this lock. How many threads can possibly acquire the lock?
To answer:Fill inAfor possible,Bfor not possible.
96. 1
A. Possible
97. 2
A. Possible
98. 3
A. Possible
99. 4
A. Possible
100. 5
A. Possible

```json
{
  "problem_id": "20",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["locks","race-condition","synchronization"],
  "choices": [
    "1",
    "2",
    "3",
    "4",
    "5"
  ],
  "answer": "A"
}
```

---

## Question 21 [1 point]

Problem XXI:Here is a ticket lock:
typedef struct __lock_t {
int ticket, turn;
} lock_t;
void lock_init(lock_t
*
lock) {
lock->ticket = 0;
lock->turn   = 0;
}
void lock(lock_t
*
lock) {
int myturn = FetchAndAdd(&lock->ticket);
while (lock->turn != myturn)
; // spin
}
void unlock(lock_t
*
lock) {
lock->turn = lock->turn + 1;
}
Assuming a maximum of 5 threads in the system, and further assuming the ticket lock is used “properly”
(i.e., threads acquire and release it as expected), what values oflock->ticketandlock->turnare
possible? (at the same time)To answer:Fill inAfor possible,Bfor not possible.
101.ticket=0andturn=0
A. Possible
102.ticket=0andturn=1
B. Not Possible
103.ticket=1andturn=0
A. Possible
104.ticket=16andturn=5
B. Not Possible
105.ticket=1000andturn=999
A. Possible

```json
{
  "problem_id": "21",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["ticket-lock","synchronization"],
  "choices": [
    "ticket=0 and turn=0",
    "ticket=0 and turn=1",
    "ticket=1 and turn=0",
    "ticket=16 and turn=5",
    "ticket=1000 and turn=999"
  ],
  "answer": "A"
}
```

---

## Question 22 [1 point]

Problem XXII:Assume the following list insertion code, which inserts into a list pointed to by shared global
variablehead:
int List_Insert(int key) {
node_t
*
n = malloc(sizeof(node_t));
if (n == NULL) { return -1; }
n->key = key;
n->next = head;
head = n;
return 0;
}
This code is executed by each of three threads exactly once, without adding any synchronization primi-
tives (such as locks). Assumingmalloc()is thread-safe (i.e., can be called without worries of data races)
and thatmalloc()returns successfully, how long might the list be when these three threads are finished
executing? (assume the list was empty to begin)
To answer:Fill inAfor possible,Bfor not possible.
106. 0
B. Not Possible
107. 1
A. Possible
108. 2
A. Possible
109. 3
A. Possible
110. 4
B. Not Possible

```json
{
  "problem_id": "22",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["concurrency","linked-list","race-condition"],
  "choices": [
    "0",
    "1",
    "2",
    "3",
    "4"
  ],
  "answer": "A"
}
```

---

## Question 23 [1 point]

Problem XXIII:Assume the following code, in which a “background malloc” allocates memory in a thread
and initializes it:
void
*
background_malloc(void
*
arg) {
int
**
int_ptr = (int
**
) arg;      // [typo from int
*
-> int
**
corrected here]
*
int_ptr = calloc(1, sizeof(int)); // allocates space for 1 int
**
int_ptr = 10;                    // calloc: also zeroes memory
return NULL;
}
int main(int argc, char
*
argv[]) {
pthread_t p1;
int
*
result = NULL;
pthread_create(&p1, NULL, background_malloc, &result);
printf("%d\n",
*
result);
return 0;
}
The code unfortunately is buggy. What are the possible outcomes of this code? Assume the calls to
pthread
create()andcalloc()succeed, and that a NULL pointer dereference crashes reliably.
To answer:Fill inAif possible,Bfor not possible.
111. The code prints out 0
A. Possible
112. The code prints out 10
A. Possible
113. The code prints out 100
B. Not Possible
114. The code crashes
A. Possible
115. The code hangs forever
B. Not Possible

```json
{
  "problem_id": "23",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["threads","memory-allocation","data-race"],
  "choices": [
    "The code prints out 0",
    "The code prints out 10",
    "The code prints out 100",
    "The code crashes",
    "The code hangs forever"
  ],
  "answer": "A"
}
```

---

## Question 24 [1 point]

Problem XXIV:Here is some more multi-threaded code:
void
*
printer(void
*
arg) {
char
*
p = (char
*
) arg;
printf("%c",
*
p);
return NULL;
}
int main(int argc, char
*
argv[]) {
pthread_t p[5];
for (int i = 0; i < 5; i++) {
char
*
c = malloc(sizeof(char));
*
c = ’a’ + i; // hint: ’a’ + 1 = ’b’, etc.
pthread_create(&p[i], NULL, printer, (void
*
) c);
}
for (int i = 0; i < 5; i++)
pthread_join(p[i], NULL);
return 0;
}
Assuming calls to all library routines succeed, which of thefollowing outputs are possible?
To answer:Fill inAif possible,Bfor not possible.
116. abcde
A. Possible
117. edcba
A. Possible
118. cccde
B. Not Possible
119. eeeee
B. Not Possible
120. aaaaa
B. Not Possible

```json
{
  "problem_id": "24",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["threads","printing","ordering"],
  "choices": [
    "abcde",
    "edcba",
    "cccde",
    "eeeee",
    "aaaaa"
  ],
  "answer": "A"
}
```

---

## Question 25 [1 point]

Problem XXV:Assume the sameprinter()function (from above), but this slightly changedmain():
void
*
printer(void
*
arg) {
char
*
p = (char
*
) arg;
printf("%c",
*
p);
return NULL;
}
int main(int argc, char
*
argv[]) {
pthread_t p[5];
for (int i = 0; i < 5; i++) {
char c = ’a’ + i;
pthread_create(&p[i], NULL, printer, (void
*
) &c);
}
for (int i = 0; i < 5; i++)
pthread_join(p[i], NULL);
return 0;
}
Assuming calls to all library routines succeed, which of thefollowing outputs are possible?
To answer:Fill inAif possible,Bfor not possible.
121. abcde
A. Possible
122. edcba
A. Possible
123. cccde
B. Not Possible
124. eeeee
A. Possible
125. aaaaa
B. Not Possible

```json
{
  "problem_id": "25",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["threads","shared-stack","race-condition"],
  "choices": [
    "abcde",
    "edcba",
    "cccde",
    "eeeee",
    "aaaaa"
  ],
  "answer": "A"
}
```

---

## Question 26 [1 point]

Problem XXVI:Assume the following multi-threaded memory allocator, roughly sketched out as follows:
int bytes_left = MAX_HEAP_SIZE;
pthread_cond_t c;
pthread_mutex_t m;
void
*
allocate(int size) {
pthread_mutex_lock(&m);
while (bytes_left < size)
pthread_cond_wait(&c, &m);
void
*
ptr = ...; // get mem from internal data structs
bytes_left -= size;
pthread_mutex_unlock(&m);
return ptr;
}
void free(void
*
ptr, int size) {
pthread_mutex_lock(&m);
bytes_left += size;
pthread_cond_signal(&c);
pthread_mutex_unlock(&m);
}
Assume all of memory is used up (i.e.,bytes
leftis 0). Then:
•One thread (T1) callsallocate(100)
•Some time later, a second thread (T2) callsallocate(1000)
•Finally, some time later, a third thread (T3) callsfree(200)
Assuming all calls to thread library functions work as expected, which of the following are possible just
after this sequence of events has taken place?
To answer:Fill inAif possible,Bfor not possible.
126. T1 and T2 remain blocked insideallocate()
A. Possible
127. T1 becomes unblocked, gets 100 bytes allocated, and returns fromallocate()
A. Possible
128. T2 becomes unblocked, gets 1000 bytes allocated, and returns fromallocate()
B. Not Possible
129. T3 becomes blocked insidefree()
B. Not Possible
130. T1, T2, and T3 become deadlocked
B. Not Possible

```json
{
  "problem_id": "26",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["memory-allocator","condition-variable","deadlock"],
  "choices": [
    "T1 and T2 remain blocked insideallocate()",
    "T1 becomes unblocked, gets 100 bytes allocated, and returns fromallocate()",
    "T2 becomes unblocked, gets 1000 bytes allocated, and returns fromallocate()",
    "T3 becomes blocked insidefree()",
    "T1, T2, and T3 become deadlocked"
  ],
  "answer": "A"
}
```

---

## Question 27 [1 point]

Problem XXVII:A Semaphore is a useful synchronization primitive. Which of the following statements
are true of semaphores?
To answer:Fill inAif true,Bfor not true.
131. Each semaphore has an integer value
A. True
132. If a semaphore is initialized to 1, it can be used as a lock
A. True
133. Semaphores can be initialized to values higher than 1
A. True
134. A single lock and condition variable can be used in tandem to implement a semaphore
A. True
135. Callingsem post()may block, depending on the current value of the semaphore
B. False

```json
{
  "problem_id": "27",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["semaphore","synchronization"],
  "choices": [
    "Each semaphore has an integer value",
    "If a semaphore is initialized to 1, it can be used as a lock",
    "Semaphores can be initialized to values higher than 1",
    "A single lock and condition variable can be used in tandem to implement a semaphore",
    "Callingsem post()may block, depending on the current value of the semaphore"
  ],
  "answer": "A"
}
```

---

## Question 28 [1 point]

Problem XXVIII:Here is the classic semaphore version of the producer/consumer problem:
void
*
producer(void
*
arg) {  // core of producer
for (i = 0; i < num; i++) {
sem_wait(&empty);
sem_wait(&mutex);
put(i);
sem_post(&mutex);
sem_post(&full);
}
}
void
*
consumer(void
*
arg) {  // core of consumer
while (!done) {
sem_wait(&full);
sem_wait(&mutex);
int tmp = get(i);
sem_post(&mutex);
sem_post(&empty);
// do something with tmp ...
}
}
For the following statements about this working solution, which statements are true, and which are not?
To answer:Fill inAif true,Bfor not true.
136. The semaphorefullmust be initialized to 0
A. True
137. The semaphorefullmust be initialized to 1
B. False
138. The semaphoreemptymust be initialized to 1
B. False
139. The semaphoreemptycan be initialized to 1
A. True
140. The semaphoremutexmust be initialized to 1
A. True

```json
{
  "problem_id": "28",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["producer-consumer","semaphores"],
  "choices": [
    "The semaphorefullmust be initialized to 0",
    "The semaphorefullmust be initialized to 1",
    "The semaphoreemptymust be initialized to 1",
    "The semaphoreemptycan be initialized to 1",
    "The semaphoremutexmust be initialized to 1"
  ],
  "answer": "A"
}
```

---

## Question 29 [1 point]

Problem XXIX:One way to avoid deadlock is to schedule threads carefully. Assume the following charac-
teristics of threads T1, T2, and T3:
•T1 (at some point) acquires and releases locks L1, L2
•T2 (at some point) acquires and releases locks L1, L3
•T3 (at some point) acquires and releases locks L3, L1, and L4
For which schedules below is deadlock possible?
To answer:Fill inAif deadlock is possible,Bfor not possible.
141. T1 runs to completion, then T2 to completion, then T3 runs
B. Not Possible
142. T1 and T2 run concurrently to completion, then T3 runs
B. Not Possible
143. T1, T2, and T3 run concurrently
A. Possible
144. T3 runs to completion, then T1 and T2 run concurrently
B. Not Possible
145. T1 and T3 run concurrently to completion, then T2 runs
B. Not Possible

```json
{
  "problem_id": "29",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["deadlock","scheduling","locks"],
  "choices": [
    "T1 runs to completion, then T2 to completion, then T3 runs",
    "T1 and T2 run concurrently to completion, then T3 runs",
    "T1, T2, and T3 run concurrently",
    "T3 runs to completion, then T1 and T2 run concurrently",
    "T1 and T3 run concurrently to completion, then T2 runs"
  ],
  "answer": "A"
}
```

---

## Question 30 [1 point]

Problem XXX:The multi-level page table is something that cannot be avoided. No matter what you do,
there it is, bringing joy and horror to us all. In this last question, you’ll get your chance at a question about
this foreboding structure. Fortunately, you don’t have to perform a translation. Instead, just answer these
true/false questions about the multi-level page table.
To answer:Fill inAif true,Bfor not true.
146. A multi-level page table may use more pages than a linearpage table
A. True
147. It’s easier to allocate pages of the page table in a multi-level table (as compared to a linear page table)
A. True
148. Multi-level page table lookups take longer than linearpage table lookups
A. True
149. With larger virtual address spaces, usually more levels are used
A. True
150. TLBs are useful in making multi-level page tables even smaller
B. False

```json
{
  "problem_id": "30",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["multi-level-page-table","TLB"],
  "choices": [
    "A multi-level page table may use more pages than a linearpage table",
    "It’s easier to allocate pages of the page table in a multi-level table (as compared to a linear page table)",
    "Multi-level page table lookups take longer than linearpage table lookups",
    "With larger virtual address spaces, usually more levels are used",
    "TLBs are useful in making multi-level page tables even smaller"
  ],
  "answer": "A"
}
```