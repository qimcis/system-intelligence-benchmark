# COMP 350 Winter 2015 Midterm

```json
{
  "exam_id": "comp_350_winter_2015_midterm",
  "test_paper_name": "COMP 350 Winter 2015 Midterm",
  "course": "COMP 350",
  "institution": "University of Waterloo",
  "year": 2015,
  "score_total": 49,
  "num_questions": 5
}
```

---

## Question 1 [5 point(s)]

Problem 1 (9 marks)
For the program shown below, assume that all function, library and system calls are successful. Recall that
the prototype/signature forthread
forkis:
int thread_fork(const char *name, struct proc *proc,
void (*func)(void *, unsigned long),
void *data1, unsigned long data2);
volatile int x = 42;
main()
{
/* name="1", no process, runs func1 */
/* parameters 0 and 0, not used */
thread_fork("1",NULL,func1,0,0);
/* name="2", no process, runs func2 */
/* parameters 0 and 0, not used */
thread_fork("2",NULL,func2,0,0);
func3(0,0);
}
void func1(unsigned long notused, void *notused2)
{
kprintf("A: %d\n", x);
x = 10;
}
void func2(unsigned long notused, void *notused2)
{
kprintf("B: %d\n", x);
x = 20;
}
void func3(unsigned long notused, void *notused2)
{
kprintf("C: %d\n", x);
x = 30;
}
When consdering each line of output produced by the program above, what would the output be when
printing the value of the variablex? If more than one value or a range of values is possible, list all possible
values or ranges.
/* From func1 */ A:
/* From func2 */ B:
/* From func3 */ C:

```json
{
  "problem_id": "1",
  "points": 5,
  "type": "Freeform",
  "tags": ["concurrency","threads","os161"],
  "answer": "A: 42 | 20 | 30; B: 42 | 10 | 30; C: 42 | 10 | 20",
  "llm_judge_instructions": "Award 5 points for listing all three lines with the exact values: A: 42 | 20 | 30; B: 42 | 10 | 30; C: 42 | 10 | 20. Award 3 points if exactly two lines are correct. Award 1 point if exactly one line is correct. Award 0 points otherwise."
}
```

---

## Question 2 [14 point(s)]

Problem 2 (14 marks)
For the program shown below, what output would be printed when it runs? If a range or multiple values are
possible, give the range or possible values. If it is not possible to determine the value, posssible values or a
range, state so and explain why. Assume that all function, library and system calls are successful. If more than
one ordering of output is possible choose one of the possibleorderings. Recall thatWEXITSTATUS(status)just
gets the exit code portion of thestatusvariable.
int x = 42;
main()
{
int rc, status;
rc = fork();
if (rc == 0) {
func1();
_exit(1);
} else {
rc = waitpid(rc, &status, 0);
printf("R: %d", WEXITSTATUS(status));
printf("M: %d\n", x);
x = 100;
printf("P: %d\n", x);
_exit(2);
}
func2();
}
void func1()
{
int rc, status;
printf("T: %d\n", x);
x = 10;
rc = fork();
if (rc == 0) {
x = 50;
printf("Q: %d\n", x);
_exit(3);
}
rc = waitpid(rc, &status, 0)
printf("A: %d\n", x);
printf("D: %d", WEXITSTATUS(status));
_exit(4);
}
void func2()
{
printf("C: %d\n", x);
}
```

```json
{
  "problem_id": "2",
  "points": 14,
  "type": "Freeform",
  "tags": ["fork","processes","wait","os"],
  "answer": "T: 42\nQ: 50\nA: 10\nD: 3\nR: 4\nM: 42\nP: 100\nNOTE C: never gets printed",
  "llm_judge_instructions": "Award 14 points for an exact match of the provided output sequence including the NOTE C line. Award 10 points if the sequence of outputs (T, Q, A, D, R, M, P) is correct but the answer omits the explicit NOTE about C never being printed. Award 7 points if at least four of the expected printed lines are correct and in the correct relative order. Award 0 points otherwise."
}
```

---

## Question 3 [12 point(s)]

Problem 5 (12 marks)
Barrier synchronization can be used to prevent threads fromproceeding until a specified number of threads
have reached the barrier. Threads reaching the barrier block until the last of the specified number of threads
has reached the barrier, at which point all threads can proceed. Below is a partial pseudocode example of how
barrier synchronization might be used.
 /* Used to wait for all mice to be ready to all attack together */
 struct barrier *attack_barrier;
 /* Used to wait for all mice and the main thread so they can all go to the bar together */
 struct barrier *bar_barrier;
 main()
 {
 unsigned int i;
 attack_barrier = barrier_create(NUM_MICE);
 bar_barrier = barrier_create(NUM_MICE+1);
 for (i=0; i<NUM_MICE; i++) {
 thread_fork("MightyMouse", mouse, NULL, i);
 }
 /* Wait here until all mice are ready to go to the bar */
 barrier_wait(bar_barrier);
 go_to_bar();
 }
 void
 mouse(void *unused, unsigned long mouse_num)
 {
 unsigned int i;
 /* Attack the cats a number of times */
 for (i=0; i<ATTACK_COUNT; i++) {
 get_ammo(mouse_num);
 barrier_wait(attack_barrier); /* wait until all mice are ready to attack */
 attack_cats();
 }
 /* Wait here until all threads are ready to go to the bar */
 barrier_wait(bar_barrier);
 go_to_bar();
 }
Fill in the spaces below (or on the next page) to complete the implementation of a barrier. (You will not
implementbarrier
destroy). You must only uselocksandcondition variablesfor synchronization (as they are defined in OS/161). To simplify the code, assume thatall calls tokmallocand to create any required
objects always succeed.

struct barrier {
};
/* Create a barrier that can be used with thread_count threads */
struct barrier *barrier_create(unsigned int thread_count)
{
}
/* Callers wait here until the number of threads specified have */
/* reached this point, then they all proceed. */
void
barrier_wait(struct barrier *b)
{
}
```

```json
{
  "problem_id": "3",
  "points": 12,
  "type": "Freeform",
  "tags": ["barrier","synchronization","os161"],
  "answer": "Code implementing barrier per solution: whole barrier structure and barrier_create/barrier_wait functions.",
  "llm_judge_instructions": "Award 4 points for a correct barrier structure containing at minimum: thread_count, current count of waiting threads, a lock, and a condition variable. Award 8 points for correct barrier_wait implementation: use the lock to protect state, increment the waiting count, if waiting count is less than thread_count then wait on the condition variable; when the last thread arrives, reset waiting count appropriately for reuse and wake all waiting threads (cv_broadcast). Partial credit may be given for substantially correct components (e.g., correct locking but missing reuse/reset logic)."
}
```

---

## Question 4 [9 point(s)]

Problem 6 (9 marks)
Some possibly useful info: 2
10
=  1 KB, 2
20
=  1 MB, 2
30
=  1 GB.
In this question all addresses, virtual page numbers and physical frame numbers are represented inoctal.
Recall that each octal character represents 3 bits. Note: tomake some numbers easier to read, spaces have
been added between every 3 octal characters. Please also usethis convention when providing your answers.
Consider a machine with39-bitvirtual addresses,33-bitphysical addresses and a page size of 262,144 bytes
(256 KB). During a program’s execution the TLB contains the following entries (all inoctal). In this example
Dirtymeans that the page can be dirtied (i.e., written to).
Virtual Page Num
Physical Frame NumValid BitDirty Bit
0 061 25206 12510
6 125 273
01 23400
0 000 061
30 13011
0 000 612
61 25211
If possible, explain how addresses given below (inoctal) will be translated and provide the requested
translated address. If a translation is not possible, explain what will happen and why. Show andexplain
how you derived your answer.Express the all physical address usingall 33-bitsand all virtual addresses
usingall 39-bits.
a.(3 mark(s))The physical address that results from a load from virtual address = 6 125 273 127 604

b.(3 mark(s))The physical address that results from a store to virtual address = 0 000 061 252 127.

c.(3 mark(s))Can a store be performed on thephysicaladdress = 61 252 612 522 If yes, provide the
virtual address used to access this physical address and if not explain precisely why not.
```

```json
{
  "problem_id": "4",
  "points": 9,
  "type": "Freeform",
  "tags": ["virtual-memory","tlb","paging"],
  "answer": "a) Translation result: TLB miss - exception (no valid entry). b) 30 130 252 127. c) 0 000 612 612 522.",
  "llm_judge_instructions": "Award 3 points for each subpart: (a) 3 points for correct identification of a TLB miss/exception when the VPN is not valid; (b) 3 points for correctly translating 0 000 061 | 252 127 to physical 30 130 252 127; (c) 3 points for correctly mapping frame 61 252 to virtual page 0 000 612 and producing virtual address 0 000 612 612 522. Partial credit: award 1-2 points within a subpart for partially correct reasoning."
}
```

---

## Question 5 [9 point(s)]

Problem 7 (9 marks)
Note: to make some numbers easier to read, spaces have been added between every 4 hexidecimal characters.
Please also use this convention when providing your answers.
The structureaddrspaceshown below describes the address space of a running processon a slightly modified
MIPS processor.  Theaddrspaceand modified processor are similar to thedumbvmand MIPS processor
provided in OS161/SYS161.  The key differences are that this processor uses 36-bit virtual and physical
addresses and a page size of 64 KB (0x1 0000). In a similar fashion to the 32-bit MIPS OS/161 processor the
36-bit virtual address space on this modified processor is divided into two halves. Virtual addresses from0to
0x7 FFFF FFFFare for user programs and virtual address from0x8 0000 0000to0xF FFFF FFFFcan not be
accessed while in user mode. Fortunately, this new version of the OS161 kernel now explicitly represents the
stack as segment 3 (note the stack size).
struct addrspace {
vaddr_t as_vbase1 = 0x0 5000 0000;      /* text segment: virtual base address */
paddr_t as_pbase1 = 0x0 0010 0000;      /* text segment: physicalbase address */
size_t as_npages1 = 0x200;              /* text segment: number of pages */
vaddr_t as_vbase2 = 0x3 0000 0000;      /* data segment: virtual base address */
paddr_t as_pbase2 = 0x8 0000 0000;      /* data segment: physicalbase address */
size_t as_npages2 = 0x137;              /* data segment: number of pages */
vaddr_t as_vbase3 = 0x4 0000 0000;      /* stack segment: virtualbase address */
paddr_t as_pbase3 = 0x1 0000 0000;      /* stack segment: physical base address */
size_t as_npages3 = 0x18;               /* stack segment: number of pages */
};
For an application executing in user space that uses the address space defined above, assume that it is accessing
the specified addresses below. When possible you are to translate the provided address. If the translation
is not possible, explain why it is not possible and what wouldhappen during translation. If the translation
is possible provide the requested translated address and indicate which segment the address belongs to. Use
hexadecimal notation for all addresses and show all 36-bits. Show and explain how you arrived at your result.
Some possibly useful values:
1 * 64 KB =  0x1 * 0x1 0000 =  0x1 0000    2 * 64 KB =  0x2 * 0x1 0000 = 0x2 0000
10 * 64 KB = 0xA * 0x1 0000 = 0xA 0000   16 * 64 KB = 0x10 * 0x1 0000 = 0x10 0000
32 * 64 KB = 0x20 * 0x1 0000 = 0x20 0000
a.(3 mark(s))Translate theVirtualAddress0x4 0017 6429to aPhysicalAddress.

b.(3 mark(s))Translate theVirtualAddress0x0 5200 AB25to aPhysicalAddress.

c.(3 mark(s))If possible, determine the user spaceVirtualAddress that could be used to access the
PhysicalAddress0x8 0128 95FA.
```

```json
{
  "problem_id": "5",
  "points": 9,
  "type": "Freeform",
  "tags": ["virtual-memory","address-space","mips"],
  "answer": "a) Part of the stack segment. 0x4 0017 6429 - 0x4 0000 0000 = 0x17 6429; final physical address 0x1 0017 6429. b) No translation. Not part of any segment. c) Part of the data segment. final physical address 0x3 0128 95FA.",
  "llm_judge_instructions": "Award 3 points for each subpart: (a) 3 points for correctly identifying the stack segment and producing physical address 0x1 0017 6429; (b) 3 points for correctly stating that the virtual address is not within any segment and explaining why; (c) 3 points for correctly mapping physical 0x8 0128 95FA to virtual 0x3 0128 95FA in the data segment. Partial credit: award 1-2 points within a subpart for partially correct reasoning."
}
```