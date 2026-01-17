# CS-537: Midterm Exam (Fall 2011)

```json
{
  "exam_id": "cs537_fall_2011_midterm",
  "test_paper_name": "CS-537: Midterm Exam (Fall 2011)",
  "course": "CS 537",
  "institution": "University of Wisconsin-Madison",
  "year": 2011,
  "score_total": 110,
  "num_questions": 22
}
```

---

## Question 1 [5 point(s)]

What does the acronym TLB stand for?

TLB stands for Translation Lookaside Buffer.

```json
{
  "problem_id": "1",
  "points": 5,
  "type": "Freeform",
  "tags": ["virtual-memory", "tlb", "memory-management"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for a correct and complete definition: 'TLB stands for Translation Lookaside Buffer, a small fast cache of recent virtual-to-physical address translations used to avoid frequent page-table lookups.' 3 points for a correct concept but incomplete phrasing or missing the explicit expansion. 0 points for incorrect or irrelevant."
}
```

---

## Question 2 [5 point(s)]

What are TLBs used for?

TLBs are used to speed up address translation by caching a subset of recent virtual-to-physical address translations, thus avoiding costly page-table lookups.

```json
{
  "problem_id": "2",
  "points": 5,
  "type": "Freeform",
  "tags": ["virtual-memory","tlb","memory-management"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for correctly stating that TLBs cache translations to accelerate address translation and reduce page-table lookups; 3 points for mentioning caching or speeding up translations with partial detail; 0 points otherwise."
}
```

---

## Question 3 [5 point(s)]

Timer interrupts are a useful mechanism for the OS. Why?

Possible answer: To keep track of time and to enable the OS to regain control of the CPU, implement time-slicing, and support scheduling or timeout mechanisms.

```json
{
  "problem_id": "3",
  "points": 5,
  "type": "Freeform",
  "tags": ["operating-systems","interrupts","scheduling"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for explaining that timer interrupts provide a time source and enable preemption/time-slicing, enabling scheduling and time-based accounting; 3 points for a partial explanation (e.g., only mention time-keeping). 0 points otherwise."
}
```

---

## Question 4 [5 point(s)]

A typical OS provides some APIs to create processes. In Unix-based systems, fork(), exec(), and wait() are used. Write some code that uses these system calls to launch a new child process, have the child execute a program named \"hello\" (with no arguments), and have the parent wait for the child to complete.

int done=0;
int rc = fork();
if (rc == 0) { // child
    char *argv [2];
    argv [0] = strdup("hello");
    argv [1] = NULL; // important!
    execvp(argv[0], argv);
    done = 1;
} else if (rc > 0) { //parent
    while (done == 0)
        ; //spin
}

```json
{
  "problem_id": "4",
  "points": 5,
  "type": "Freeform",
  "tags": ["process-management","unix","systems-programming"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for providing correct Unix-like code sequence that forks, child execs a program named 'hello' with no args, and parent waits (using wait() or proper synchronization) rather than busy-waiting; 3 points for a correct approach but with a non-ideal synchronization; 0 points otherwise."
}
```

---

## Question 5 [5 point(s)]

To compare scheduling policies, we often use certain metrics. Here we use a new metric: total completion time. The total completion time tells us when all of the jobs in a workload are done. What do you think about this metric?

I think it's great professor! Very useful.

```json
{
  "problem_id": "5",
  "points": 5,
  "type": "Freeform",
  "tags": ["scheduling","metrics","operating-systems"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for a thoughtful answer addressing that total completion time emphasizes overall batch finish time, can conflate CPU bound and I/O-bound effects, may obscure per-job fairness; 3 points for partial insight; 0 points otherwise."
}
```

---

## Question 6 [5 point(s)]

One of the best scheduling policies out there is shortest-time-to-completion first, or STCF. What does STCF do? If it's so great, why do we rarely see it implemented?

STCF: picks the job with the least time left to run and runs it. It's the preemptive generalization of SJF. Why rarely used: challenges estimating remaining time; implementation in C can make correctness hard; or variability in runtimes makes accurate time estimates difficult.

```json
{
  "problem_id": "6",
  "points": 5,
  "type": "Freeform",
  "tags": ["scheduling","policy","stcf"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for stating the core idea (least time left, preemption, generalization of SJF) and the practical challenge (estimating time-to-completion, runtime variability); 3 points for partial explanation; 0 points otherwise."
}
```

---

## Question 7 [5 point(s)]

In the MLFQ scheduler, there is a rule that states the following:

   Rule 5: After some time period S, move all the jobs in the system
   to the top-most queue.

   What is the purpose of this rule?

To confuse me?

---

```json
{
  "problem_id": "7",
  "points": 5,
  "type": "Freeform",
  "tags": ["scheduling","mlfq","operating-systems"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for explaining that this rule is intended to prevent starvation and to ensure that long-running jobs eventually return to the top (or to simulate aging). 3 points for partial reasoning; 0 points otherwise."
}
```

---

## Question 8 [5 point(s)]

Lottery scheduling uses tickets to represent a share of the CPU. Thus, if process A has 100 tickets, and another process B has 200, process A should run roughly 1/3 of the time. Does lottery scheduling prevent starvation?

NO! Lottery scheduling has been around for a long time, and there are still people starving all around the world. : (

Q!)Of mf it does change?

```

```json
{
  "problem_id": "8",
  "points": 5,
  "type": "Freeform",
  "tags": ["scheduling","lottery","starvation"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for acknowledging that lottery scheduling reduces the chance of starvation probabilistically but does not absolutely prevent it; mention that starvation can still occur if ticket allocation is highly imbalanced or due to variance; 3 points for partial reasoning; 0 points otherwise."
}
```

---

## Question 9 [5 point(s)]

A user can allocate memory by calling malloc() and free it by calling free(). When a user doesn't call free(), it is called a ``memory leak''. When is it OK to have a memory leak in your program?

NEVER! (how dare you even suggest this!)

```json
{
  "problem_id": "9",
  "points": 5,
  "type": "Freeform",
  "tags": ["memory-management","malloc","leaks"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for stating that leaks are typically unacceptable, with caveats such as very short-lived programs where the OS reclaims memory on exit; 3 points for acknowledging context where leaks may be tolerated; 0 points otherwise."
}
```

---

## Question 10 [5 point(s)]

In a system using a base-and-bounds pair of registers to virtualize a tiny 1KB address space, we see the following address reference trace:

Virtual Address Trace
VA 0: 0x00000308 (decimal: 776) --> VALID: 0x00003913 (decimal: 14611)
VA 1: 0x00000255 (decimal: 597) --> VALID: 0x00003860 (decimal: 14432)
VA 2: 0x000003A1 (decimal: 929) --> SEGMENTATION VIOLATION

What can we say about the value of the base register? What about the bounds register?

Compute base by subtracting: 14611 - 776 = 13835
Compute base again              : 14432-597 = 13835 (base 
                                                                                       (changed?)
Bounds: can't say anything about it (not enough info)

```

```json
{
  "problem_id": "10",
  "points": 5,
  "type": "Freeform",
  "tags": ["virtual-memory","address-translation","base-bounds"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for correctly deriving that base = 13835 from both valid references and noting that the bounds cannot be precisely determined from the given data; explain that the third access caused a violation due to exceeding bounds; 3 points for partial reasoning; 0 points otherwise."
}
```

---

## Question 11 [5 point(s)]

Base and bounds (or dynamic relocation) has some strengths and weaknesses as a mechanism for implementing virtual memory. What are they? (list)

        Strengths                                   Weaknesses
        --> Simple                                 --> Not complex
        --> Fast                                     --> Not Slow

```

```json
{
  "problem_id": "11",
  "points": 5,
  "type": "Freeform",
  "tags": ["virtual-memory","base-and-bounds","memory-management"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for listing core strengths (simple, fast, low overhead) and weaknesses (limited flexibility, fragmentation, fixed size; difficulties with dynamic or sparse address spaces). 3 points for partial correctness; 0 points otherwise."
}
```

---

## Question 12 [5 point(s)]

Segmentation is a generalization of base and bounds. What are its strengths and weaknesses? umm .... something about fragmentation?

```

```json
{
  "problem_id": "12",
  "points": 5,
  "type": "Freeform",
  "tags": ["segmentation","virtual-memory","memory-management"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for listing clear strengths (protection, support for sparse address spaces, potential for reduced internal fragmentation) and weaknesses (external fragmentation, variable-sized segments, management overhead). 3 points for partial correctness; 0 points otherwise."
}
```

---

## Question 13 [5 point(s)]

Here we have a trace of virtual address references in a segmented system. The system has two segments in each address space, and uses the first bit of the virtual address to differentiate which segment a reference is in. Segment 0 holds code and a heap (and therefore grows in the positive direction); Segment 1 holds a stack (and therefore grows in the negative direction). Please translate the following references, or mark a segmentation violation if the address reference is out of bounds.

The address space size is 16 bytes (tiny!).

The physical memory is only 64 bytes (also tiny!).

Here is some segment register information:
   Segment 0 base (grows positive) : 0x30 (decimal 48)
   Segment 0 limit                 : 7

   Segment 1 base (grows negative) : 0x09 (decimal 9)
   Segment 1 limit                 : 4

And here is the Virtual Address Trace:
   VA 0: 0x0000000e (decimal: 14) --> 7

   VA 2: 0x00000006 (decimal:     6) --> 54

   VA 4: 0x0000000a (decimal: 10) --> 3

    virT.             phys.
   Seg 0  | 0 -------->
   Seg 1  |      4 ---|
           :          :
           :          |
          9           48

```

```json
{
  "problem_id": "13",
  "points": 5,
  "type": "Freeform",
  "tags": ["segmentation","address-translation","memory-management"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for correctly translating/validating each VA to a physical address within bounds or returning a segmentation fault when out of bounds, matching the given segment bases/limits and growth directions. 3 points for partial correctness; 0 points otherwise."
}
```

---

## Question 14 [5 point(s)]

A system uses paging to implement virtual memory. Specifically, it uses a simple linear page table. The virtual address space is of size 1 GB (30 bits); the page size is 1 KB; each page table entry holds only a valid bit and the resulting page-frame number (PFN); the system has a maximum of $2^{15}$ physical pages (32 MB of physical memory can be addressed at most).

How much memory is used for page tables, when there are 100 processes running in the system?

\\[ \\text{VA} \\| \\underbrace{\\text{VPN}}_{20 \, \\text{bits}} \\underbrace{\\text{offset}}_{10 \, \\text{bits}} \\]

=> size of page table
is thus 2^20 or

1 MB

=> if 100 processes,

100 MB

6

```json
{
  "problem_id": "14",
  "points": 5,
  "type": "Freeform",
  "tags": ["paging","page-tables","memory-management"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for calculating per-process page table size as 2^20 entries; if each entry is at least 1 bit for valid and PFN, mention a typical PFN size; in many setups with a PFN of 1+ bits, the total may be 2 bytes or more per entry. The classic correct answer given here is 100 MB if each PTE is 1 byte; but the exam's reference indicates 2 bytes per PTE leading to 200 MB. Provide a rubric: 5 points for recognizing 2^20 entries per process and multiplying by 100 processes; 0-3 points depending on whether the PFN/valid bits encoding is properly accounted for. For this specific exam, align with 100 MB if you treat each PTE as 1 byte; or 200 MB if 2 bytes per PTE. Be consistent with your chosen assumption."
}
```

---

## Question 15 [5 point(s)]

TLBs are critical in the implementation of a virtual memory. Assume the following code snippet:

int i;
int p[1024];
for (i = 0; i < 1024; i++)
   p[i] = 0;

Describe the TLB behavior during this sequence. How many hits and how many
misses take place when this code is first run? Assume a 1-KB page size.

Too hard! You are a mean professor.

Each int is 4 bytes => 1024 ints => 4 KB
If they line up exactly on a page boundary 
=> 4 pages otherwise 5
Also, code pages for instruction fetch:
=> either 1 (or two if code spans 2 pages)
Thus -> 6 TLB misses

```json
{
  "problem_id": "15",
  "points": 5,
  "type": "Freeform",
  "tags": ["tlb","memory-management","virtual-memory"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for a plausible analysis stating that the first access to each page results in a miss and subsequent accesses on the same page are hits; account for the number of pages touched by the 1024 ints given 1 KB page size (likely 2-5 pages depending on layout) and include instruction fetch pages. Since the provided solution text indicates this is intentionally difficult, give partial credit for correct identification of page-footprint and the basic hit/miss pattern; 0-3 points otherwise."
}
```

---

## Question 16 [5 point(s)]

A system uses multi-level page tables to implement virtual memory. It’s a simple two-level table, with a page directory that points to pieces of the page table. Each page directory is only a single page, and consists of 32 page-directory entries (PDEs). A PDE has a simple format: a valid bit followed by the PFN of the page of the page table (if valid). Here is one entire page directory (wrapped across two lines):

7f fe 7f 7f 7f d4 7f 7f 7f 9c 7f ad 7f 7f 7f d6 
7f fe 7f 7f 7f fe 7f e9 a1 08 7f 7f 7f 7f 7f 7f

How much space savings (in bytes) does this multi-level page table provide, as compared to a typical linear page table? x 7f => 0111111
                                         valid bit = 0
PDE: |v| PFN
above: I circled valid entries => 8 total
                                    (24 not valid)

=> 24 pages savings (x 32 byte for
                           byte savings)

                                                                  7

```json
{
  "problem_id": "16",
  "points": 5,
  "type": "Freeform",
  "tags": ["paging","multilevel-page-tables","memory-management"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for correctly computing space savings given 8 valid PDEs out of 32 entries; account for the page directory itself and the per-page directory/page table overhead. As per the provided solution, the expected answer indicates a very small savings (the note shows concluding '7'). Provide a rubric: 5 for correct calculation with explicit counting of valid PDEs and the resulting saved space; 3 for partial reasoning; 0 otherwise."
}
```

---

## Question 17 [5 point(s)]

LRU is considered a good page-replacement policy. Describe what a good page-replacement policy should do, what LRU (least-recently-used) replacement is.

A good policy minimizes the miss rate by keeping popular pages in memory. LRU does this by keeping the least-recently-used pages in memory.

```json
{
  "problem_id": "17",
  "points": 5,
  "type": "Freeform",
  "tags": ["paging","memory-management","lr u"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for correctly describing a good policy in terms of minimizing misses and explaining LRU as evicting the least recently used page; 3 points for partial explanation; 0 points otherwise."
}
```

---

## Question 18 [5 point(s)]

LRU also has its downsides. Describe a case where LRU behaves really poorly.

Trick question! LRU never does poorly!

```json
{
  "problem_id": "18",
  "points": 5,
  "type": "Freeform",
  "tags": ["paging","memory-management","lr u"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for describing a pathological access pattern where the working set changes faster than the system can adapt (e.g., looping over a large set while memory holds a smaller working set, causing continual misses). 0 points for the 'never does poorly' answer; provide a correction for partial credit."
}
```

---

## Question 19 [5 point(s)]

LRU is hard to implement perfectly. Instead, most systems use reference bits to approximate LRU. How are reference bits used?

Reference bit gets set (in PTE) when a page is referenced (accessed).
Thus, to evict a page, all OS has to do is scan and find a page w/ ref bit = 0.

```json
{
  "problem_id": "19",
  "points": 5,
  "type": "Freeform",
  "tags": ["paging","lr u","memory-management"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for describing the use of a reference bit per page to indicate recent use and the basic idea of scanning for a page with ref=0; optionally mention clearing bits over time (second-chance/clock algorithm). 3 points for partial explanation; 0 otherwise."
}
```

---

## Question 20 [5 point(s)]

The atomic exchange (or test-and-set) instruction returns the old value of a memory location while setting it to a new value, atomically. It can be used to implement a spin lock. Please do so!

struct lock-t {
     int flag;
}
⇒mutex-lock (struct lock-t * m) {
     while ( xchg ( &m→flag, 2) == 2) 
    ; // spin
 }

⇒mutex-init (struct lock-t *m){
     m→flag = 0;
 }

⇒mutex-unlock (struct lock-t *m) {
     m→flag = 0;
 }

```json
{
  "problem_id": "20",
  "points": 5,
  "type": "Freeform",
  "tags": ["synchronization","atomic-ops","spin-lock"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for a correct spin-lock implementation using test-and-set semantics (setting flag to a non-zero value and looping while the previous value indicates it's held). 3 points for partial correctness (e.g., a-typical use or missing memory barriers). 0 points otherwise."
}
```

---

## Question 21 [5 point(s)]

Condition variables are useful in certain types of multi-threaded programs. Describe what a condition variable is, and show an example of how you would use one in a little code snippet.

     forgot to study this ⇒ be kind  ❜❜

```json
{
  "problem_id": "21",
  "points": 5,
  "type": "Freeform",
  "tags": ["synchronization","condition-variables","multithreading"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for describing a condition variable as a synchronization primitive that allows threads to sleep until a condition is true and giving a simple example with a mutex, wait, and signal/broadcast; 3 points for partial explanation; 0 points otherwise."
}
```

---

## Question 22 [5 point(s)]

In class we discussed the producer/consumer problem, and provided this (broken) solution:

void *producer(void *arg) {
    int i;
    while (1) {
        mutex_lock(&mutex);          // line p1
        if (count == MAX)            // line p2
            cond_wait(&empty, &mutex); // line p3
        put(i);                      // line p4
        cond_signal(&full);          // line p5
        mutex_unlock(&mutex);        // line p6
    }
}

void *consumer(void *arg) {
    int i;
    while (1) {
        mutex_lock(&mutex);          // line c1
        if (count == 0)              // line c2
            cond_wait(&full, &mutex); // line c3
        int tmp = get();             // line c4
        cond_signal(&empty);         // line c5
        mutex_unlock(&mutex);        // line c6
        printf("%d\n", tmp);
    }
}

Describe why this solution is broken, and demonstrate it with a specific example of thread interleavings (assume two consumers and one producer):

Something to do with the if ?

```

```json
{
  "problem_id": "22",
  "points": 5,
  "type": "Freeform",
  "tags": ["concurrency","producer-consumer","condition-variables"],
  "choices": [],
  "answer": "",
  "llm_judge_instructions": "Grading rubric: 5 points for identifying the classic pitfall (using if with cond_wait leading to missed wakeups or spurious wakeups) and providing a concrete interleaving showing how a consumer can attempt to get from an empty buffer or a producer can miss signaling; 3 points for partial reasoning; 0 points otherwise."
}
```