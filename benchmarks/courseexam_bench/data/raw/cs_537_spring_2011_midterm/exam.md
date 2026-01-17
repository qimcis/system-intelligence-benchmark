# CS 537 Spring 2011 Midterm

```json
{
  "exam_id": "cs_537_spring_2011_midterm",
  "test_paper_name": "CS 537 Spring 2011 Midterm",
  "course": "CS 537",
  "institution": "University of Wisconsin-Madison",
  "year": 2011,
  "score_total": 100,
  "num_questions": 8
}
```

---

## Question 1 [12 point(s)]

PROBLEM 1: BASICS OF SCHEDULING (page 4)

Scheduling policies can be easily depicted with some graphs. For example,
let's say we run job A for 10 time units, and then run job B for 10 time
units. Our graph of this policy might look like this:
      |
CPU   |AAAAAAAAAABBBBBBBBBB
      |_____________________
       0       10       20

In this question, you'll show your understanding of scheduling by drawing
a few of these pictures.

(a) Draw a picture of Shortest Job First (SJF) scheduling with three jobs,
A, B, and C, with run times of 5, 10, and 15 time units, respectively.

Make sure to LABEL the x-axis appropriately.

      |
CPU   |
      |_______________________________________________________

(b) What is the average TURNAROUND TIME for jobs A, B, and C?

(c) Draw a picture of ROUND-ROBIN SCHEDULING for jobs A, B, and C, which
each run for 6 time units, assuming a 2-time-unit time slice; also assume
that the scheduler (S) takes 1 time unit to make a scheduling decision.

Make sure to LABEL the x-axis appropriately.

      |
CPU   |
      |_______________________________________________________

(d) What is the average RESPONSE TIME for round robin for jobs A, B, and C?

(e) What is the average TURNAROUND TIME for round robin for jobs A, B, and C?

```json
{
  "problem_id": "1",
  "points": 12,
  "type": "Freeform",
  "tags": ["operating-systems", "scheduling"],
  "llm_judge_instructions": "Rubric: Evaluate parts (a)-(e) for correctness. Distribute 12 points across subparts: a=3, b=3, c=3, d=2, e=1. Accept textual descriptions and diagrams that correctly depict SJF and RR behaviors, and correct turnaround/response calculations."
}
```

---

## Question 2 [12 point(s)]

PROBLEM 2: MLFQ                                                                         (page 5)

Assume you have a multi-level feedback queue (MLFQ) scheduler.
In this question, we'll draw a picture of how it behaves over time.

(a) Assume a 3-level MLFQ (high priority is 2, low priority is 0).
Assume two jobs (A and B), both BATCH jobs (no I/O), each with a
run-time of 10 time units, and both entering the system at T=0.
Assume the quantum length at the highest priority level is 1,
then 2 at the middle, and 3 for the lowest priority.

Draw a picture of how the scheduler behaves for these jobs.
Make sure to LABEL the x-axis.

```
   2 |
     |
Priority 1 |
     |
   0 |
   |—————————————————————————————————————————————————————————
```

(b) Assume the same scheduling parameters as above. Now the jobs
are different; A and B both are BATCH jobs that each run for 10 time
units (no I/O again), but this time A enters at T=0 whereas B enters
the system at T=6.

Draw a picture of how the scheduler behaves for these jobs.
Make sure to LABEL the x-axis.

```
   2 |
     |
Priority 1 |
     |
   0 |
   |—————————————————————————————————————————————————————————
```

(c) Calculate the RESPONSE TIME and TURNAROUND TIME (in part b) for Job A

(d) Calculate the RESPONSE TIME and TURNAROUND TIME (in part b) for Job B

```json
{
  "problem_id": "2",
  "points": 12,
  "type": "Freeform",
  "tags": ["operating-systems", "mlfq", "scheduling"],
  "llm_judge_instructions": "Rubric: Part (a) and (b) diagrams deserve 3 points each; (c) and (d) timing calculations deserve 3 points total (2 for correct R and T for A, 1 for B or distribute evenly). Provide clear timing interpretation and axis labeling."
}
```

---

## Question 3 [12 point(s)]

PROBLEM 3: MALLOC AND FREE                                   (page 6)

Assume you have a chunk of memory that you need to manage. When someone requests a chunk, you take the first available chunk and return it, starting at the lowest address in the space you are managing (i.e., a LOWEST-ADDRESS-FIRST policy, perhaps). The space is managed with a simple free list; when someone returns a chunk, you COALESCE the list, thus merging smaller allocated chunks back into a bigger free space.

Assuming you have 50 bytes of memory to manage, and that exactly one allocation has taken place (for 10 bytes), here is what memory would look like (with spaces in-between every 10 bytes for readability):

HHHHAAAAAA AAAAAAAAAA AAAAAAAAAA AAAAAAAAAA AAAAAAAAFF FFFFFFFFFF

  (low)           Addresses of Managed Space                (high)

In the picture, A means allocated, F means free, and H is a 4-byte
header that is REQUIRED before every allocated chunk.

(a) Assume a 50-byte free space. Draw what it would look like after these requests: allocate(10), allocate(10), and allocate(10).

(b) Assume a 50-byte free space. Draw what it would look like after allocation requests of allocate(10), allocate(20), and allocate(20).

(c) Assume a 50-byte free space. Draw what it would look like after the following requests: x=allocate(10), y=allocate(10), z=allocate(10), free(y), w=allocate(24).

(d) Assume now that there is NO COALESCING of free space.
Also assume that instead of allocating via the policy of LOWEST-ADDRESS-FIRST, you instead use a BEST-FIT policy.
Assume a 50-byte free space. Draw what it would look like after the following requests: x=allocate(10), y=allocate(10),
z=allocate(10), free(y), free(z), w=allocate(4).

```json
{
  "problem_id": "3",
  "points": 12,
  "type": "Freeform",
  "tags": ["memory-management", "allocators", "dynamic-memory"],
  "llm_judge_instructions": "Rubric: For each subpart, evaluate correctness of the free-list representation and coalescing behavior. Distribute 12 points across (a)-(d) with roughly 3 points each, but adjust as needed to reflect diagram accuracy and fragmentation reasoning."
}
```

---

## Question 4 [12 point(s)]

PROBLEM 4: SEGMENTATION                                                        (page 7)

Assume virtual memory hardware that uses segmentation, and divides
the address space in two by using the top bit of the virtual address.
Each segment is thus relocated independently.

What we'll be drawing in this question is what physical memory looks
given some different parameters. We'll also label where a particular
memory reference ends up.

For all questions, assume a virtual address space of size 16 bytes
(yes tiny!) and a physical memory of size 64 bytes. Thus, if we had
a virtual address space placed in physical memory, it might look
like this (with spaces between every 8 physical bytes):

0000FFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF FFFF1111

In this example, the segment 0 base register is 0, segment 1 base is
64 (it grows backwards), and both length registers are 4. 0's are
used to record where segment 0 is in memory; 1's are for segment 1;
F means free.

(a) What would physical memory look like if we had the following
values instead? (draw a picture below)

seg0 (base)  : 12     seg0 (limit)  : 6
seg1 (base)  : 10     seg1 (limit)  : 3

(b) In your picture above, CIRCLE which byte of memory is accessed
when the process generates a byte load of virtual address 4
(or DRAW AN X on the physical-memory address if the access is illegal)

(c) What would physical memory look like if we had the following
values instead? (draw a picture below)

seg0 (base)  : 40      seg0 (limit) : 4
seg1 (base)  : 50      seg1 (limit) : 4

(d) In your picture above, CIRCLE which byte of memory is accessed
when the process generates a byte load of virtual address 14
(or DRAW AN X on the physical-memory address if the access is illegal)

(e) In your picture above, CIRCLE which byte of memory is accessed
when the process generates a byte load of virtual address 4
(or DRAW AN X on the physical-memory address if the access is illegal)

```json
{
  "problem_id": "4",
  "points": 12,
  "type": "Freeform",
  "tags": ["segmentation", "virtual-memory"],
  "llm_judge_instructions": "Rubric: For each subpart (a)-(e), assess accuracy of the drawn physical memory and the identified referenced byte. Each subpart worth 2-3 points; total 12 across the problem. Provide textual justification where diagrams are omitted."
}
```

---

## Question 5 [12 point(s)]

PROBLEM 5: SIMPLE PAGING                                 (page 8)

Which memory is accessed during the execution of an instruction? 
For this question, assume a linear page table, with a 1-byte 
page-table entry. Assume an address space of size 128 bytes 
with 32-byte pages. Assume a physical memory of size 128 bytes. 
The page-table base register is set to physical address 16. 
The contents of the page table are: 

       VPN               PFN
         0                 1
         1          Not valid
         2                 3
         3          Not valid

Now, finally assume we have the following instruction, which 
loads a SINGLE BYTE from virtual address 70 into register R1:
    10: LOAD 70, R1
This instruction resides at virtual address 10 within the 
address space of the process. 

In the diagram of physical memory below: 

(a) Put a BOX around each valid virtual page (and label them)

(b) Put a BOX around the page table (and label it)

(c) CIRCLE the memory addresses that get referenced during 
the execution of the instruction, including both instruction 
fetch and data access (there is no TLB). 

(d) LABEL these addresses with a NUMBER that indicates the ORDER 
in which various physical addresses get referenced. 

                     Physical Memory 
     0       1       2       3       4       5       6       7
     8       9      10      11      12      13      14      15
    16      17      18      19      20      21      22      23
    24      25      26      27      28      29      30      31  
    32      33      34      35      36      37      38      39
    40      41      42      43      44      45      46      47
    48      49      50      51      52      53      54      55
    56      57      58      59      60      61      62      63
    64      65      66      67      68      69      70      71
    72      73      74      75      76      77      78      79
    80      81      82      83      84      85      86      87
    88      89      90      91      92      93      94      95
    96      97      98      99     100     101     102     103
   104     105     106     107     108     109     110     111
   112     113     114     115     116     117     118     119
   120     121     122     123     124     125     126     127

```json
{
  "problem_id": "5",
  "points": 12,
  "type": "Freeform",
  "tags": ["paging", "virtual-memory", "address-translation"],
  "llm_judge_instructions": "Rubric: (a) identify valid virtual pages; (b) label the page table; (c) circle referenced addresses during instruction fetch and data access; (d) order the physical addresses referenced. Distribute 12 points across the four parts."
}
```

---

## Question 6 [12 point(s)]

PROBLEM 6: THE TLB, PAGE FAULTS, ETC.                           (page 9)

In this question, you will examine virtual memory reference traces.  
An access can be a TLB hit or a TLB miss; if it is a TLB miss, the
reference can be a page hit (present) or a page fault (not present).

Assume a TLB with 4 entries, and a memory that can hold 8 pages.
Assume the TLB and memory both are empty initially. Finally, assume
LRU replacement is used for both the TLB and memory.

(a) What happens on each access in the following reference trace?
a TLB hit, TLB miss/page hit, or TLB miss/page fault?
(these can be abbreviated H, M, or PF)

0 PF
1 PF
2 PF
3 PF
0 H      } after faulting in,
1 H      } all are in mem
2 H      } and mapped in TLB
3 H

(b) What happens on each access in the following reference trace?
(write H, M, or PF)

0 PF
1 PF
2 PF
3 PF
4 PF
0 M      } this time, pages are in
1 M      } memory, but TLB
2 M      } not big enough => TLB misses
3 M
4 M

(c) Now assume a memory that can only hold 3 pages.
What happens on each access in the following reference trace? (H, M, PF)

0 PF                 LRU -> 0 1 2
1 PF                   1  2  0
2 PF                   2  0  1
0 H                   0  1  3
3 PF                1  3  0
0 H                i     0  3
3 H                i     3  1
1 H                3  i  2
2 PF            3  1   
1 H

      TLB : big enough to hold
      all mappings => no TLB misses
```

```json
{
  "problem_id": "6",
  "points": 12,
  "type": "Freeform",
  "tags": ["tlb","paging","virtual-memory"],
  "llm_judge_instructions": "Rubric: For each trace, assign H/M/PF accordingly per step. (a) 4 steps; (b) 5 steps; (c) 9 steps. Provide justification for M and PF when needed. Total 12 points distributed across parts."
}
```

---

## Question 7 [12 point(s)]

PROBLEM 7: MULTI-LEVEL PAGE TABLES                              (page 10)

In this question, we’ll examine a multi-level page table, like that 
found in the (optional) homework. The parameters are the same:

- The page size is an unrealistically-small 32 bytes. 
- The virtual address space for the process in question 
  (assume there is only one) is 1024 pages, or 32 KB.
- Physical memory consists of 128 pages.

Thus, a virtual address needs 15 bits, 5 of which are the offset.
A physical address requires 12 bits, also with 5 as the offset.

The system assumes a multi-level page table. Thus, the upper five bits of a 
virtual address are used to index into a page directory; the page directory entry 
(PDE), if valid, points to a page of the page table. Each page table page
holds 32 page-table entries (PTEs). Each PTE, if valid, holds the desired
translation (physical frame number, or PFN) of the virtual page in question.

The format of a PTE is thus:
  VALID 1 PFN7 PFN6 ... PFN0

and is thus 8 bits or 1 byte.

The format of a PDE is essentially identical:
  VALID 1 PT7 PT6 ... PT0

For this question, assume the PDBR (page-directory base register) is 73.

On the next page is the physical memory dump, where your answers will go.

(a) CIRCLE which bytes are accessed during a load from virtual address 0x3009.

(b) Put SQUARES around bytes accessed during a load from 0x7042.

```json
{
  "problem_id": "7",
  "points": 12,
  "type": "Freeform",
  "tags": ["paging","multi-level-page-tables","virtual-memory"],
  "llm_judge_instructions": "Rubric: Identify bytes accessed for each load; use circles and squares as described. Distribute 12 points across parts (a) and (b)."
}
```

---

## Question 8 [16 point(s)]

PROBLEM 8: VIRTUAL MACHINE MONITORS                                      (page 13)

Ah, virtual machine monitors. You use them, and now (hopefully)
you understand them (a little bit).

Assume in this question some hardware that has a software-managed
TLB.

Assume we are running a virtual machine monitor (VMM), an operating
system (OS) on top of the VMM, and a user process running on the OS.

Draw a picture of the control flow during a TLB miss generated
by the user process. The picture should reflect a time-line of
what happens during this miss, including when the user process,
OS, and VMM run, and what they do when they run.

        APP
            1 
              TLB
              miss    

        OS

            3                              9
             OS tue                        lookup in
           miss handler                        PT,
                                            install in 
                                              TLB

        VMM

            2
             TLB
          miss handler

                                             
                                          6
                                              rett
                          rett

                              5                                  7
                                 illegal inst.                      illegal 
                                  fault: why                        OK!
                                  update                            TLB  

                                           ↑
                                         retrv:
                                          inst         

(there is a diagram illustrating the flow described above)

```json
{
  "problem_id": "8",
  "points": 16,
  "type": "Freeform",
  "tags": ["virtual-machine-monitors","tlb","virtualization"],
  "llm_judge_instructions": "Rubric: Evaluate the correctness of the described control-flow timing and responsibilities of User process, OS, and VMM during a TLB miss. Provide a narrative or diagram interpretation; allocate 16 points based on completeness and accuracy of the control flow depiction."
}
```