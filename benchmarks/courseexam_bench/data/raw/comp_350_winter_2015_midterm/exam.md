# COMP 350 Winter 2015 Midterm

```json
{
  "exam_id": "comp_350_winter_2015_midterm",
  "test_paper_name": "COMP 350 Winter 2015 Midterm",
  "course": "COMP 350",
  "institution": "University of Waterloo",
  "year": 2015,
  "score_total": 53,
  "num_questions": 5
}
```

---

## Question 1 [9 point(s)]

For the program shown below, assume that all function, library and system calls are successful. Recall that the prototype/signature for thread_fork is:
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
When considering each line of output produced by the program above, what would the output be when printing the value of the variable x? If more than one value or a range of values is possible, list all possible values or ranges.
/* From func1 */ A:
/* From func2 */ B:
/* From func3 */ C:
```json
{
  "problem_id": "1",
  "points": 9,
  "type": "Freeform",
  "tags": ["threads","concurrency","kernel"],
  "answer": "A: 42 | 20 | 30\nB: 42 | 10 | 30\nC: 42 | 10 | 20",
  "llm_judge_instructions": "Award 9 points for exactly matching one of the listed outputs. Partial credit: award 3 points for partial correctness if some values align with the provided possibilities."
}
```

---

## Question 2 [14 point(s)]

For the program shown below, what output would be printed when it runs? If a range or multiple values are possible, give the range or possible values. If it is not possible to determine the value, possible values or a range, state so and explain why. Assume that all function, library and system calls are successful. If more than one ordering of output is possible choose one of the possible orderings. Recall that WEXITSTATUS(status) just gets the exit code portion of the status variable.
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
```json
{
  "problem_id": "2",
  "points": 14,
  "type": "Freeform",
  "tags": ["fork","process-control","exit-status","wait"],
  "answer": "T: 42\nQ: 50\nA: 10\nD: 3\nR: 4\nM: 42\nP: 100\nNOTE C: never gets printed",
  "llm_judge_instructions": "Award 14 points for exact output sequence. If minor variations are possible, provide partial credit as appropriate."
}
```

---

## Question 3 [12 point(s)]

Problem 5 (12 marks)
Barrier synchronization can be used to prevent threads from proceeding until a specified number of threads have reached the barrier. Threads reaching the barrier block until the last of the specified number of threads has reached the barrier, at which point all threads can proceed. Below is a partial pseudocode example of how barrier synchronization might be used.
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
Fill in the spaces below (or on the next page) to complete the implementation of a barrier. (You will not implement barrier_destroy). You must only use locks and condition variables for synchronization (as they are defined in OS/161). To simplify the code, assume that all calls to kmalloc and to create any required objects always succeed.
CS3508 of 13

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
```json
{
  "problem_id": "5",
  "points": 12,
  "type": "Freeform",
  "tags": ["barrier","synchronization","os161"],
  "answer": "struct barrier {\n/* This MUST be volatile */\nvolatile unsigned int b_threads_reached;   /* how many have reached the barrier */\n/* This does not need to be volatile, only changed by one thread at init time */\nunsigned int b_threads_expected;           /* num threads to wait for*/\nstruct lock *b_lock;                       /* lock used to protect count and reached */\nstruct cv *b_cv;                           /* cv used to wait when needed */\n};\nstruct barrier *barrier_create(unsigned int thread_count)\n{\nstruct barrier *b = (struct barrier *) kmalloc(sizeof(barrier));\nb->b_lock = lock_create(\"barrier\");\nb->b_cv = cv_create(\"barrier\");\nb->b_threads_expected = thread_count;\nb->b_threads_reached = 0;\nreturn b;\n}\nbarrier_wait(struct barrier *b)\n{\nlock_acquire(b->b_lock);\nb->b_threads_reached++;\nif (b->b_threads_reached == b->b_threads_expected) {\n/* Must reset number of threads reached to use the barrier more than once */\n/* This could be done before or after broadcast */\nb->b_threads_reached = 0;\ncv_broadcast(b->b_cv, b->b_lock);\n} else {\ncv_wait(b->b_cv, b->b_lock);\n}\nlock_release(b->b_lock);\n}\n\nCOMMON MISTAKES\nNot making the barrier_wait reusable, forgetting to use volatile where needed, using a while loop\n/* Common incorrect solution -- with while loop */\nbarrier_wait(struct barrier *b)\n{\nlock_acquire(b->b_lock);\nb->b_threads_reached++;\nwhile (b->b_threads_reached < b->b_threads_expected) {\ncv_wait(b->b_cv, b->b_lock);\n}\ncv_broadcast(b->b_cv, b->b_lock);\nb->b_threads_reached = 0;\nlock_release(b->b_lock);\n}\n",
  "llm_judge_instructions": "Award 12 points for a correct barrier implementation using locks and condition variables as described. Partial credit for partial functionality (e.g., single-use barrier or missing reset)."
}
```

---

## Question 4 [9 point(s)]

Problem 6 (9 marks)
Some possibly useful info: 2^10 = 1 KB, 2^20 = 1 MB, 2^30 = 1 GB.
In this question all addresses, virtual page numbers and physical frame numbers are represented in octal. Recall that each octal character represents 3 bits. Note: to make some numbers easier to read, spaces have been added between every 3 octal characters. Please also use this convention when providing your answers.
Consider a machine with 39-bit virtual addresses, 33-bit physical addresses and a page size of 262,144 bytes (256 KB). During a program’s execution the TLB contains the following entries (all in octal). In this example Dirty means that the page can be dirtied (i.e., written to).
Virtual Page Num  | Physical Frame Num | Valid Bit | Dirty Bit
0 061             | 25206              | 1         | 2? 5? 10  (note: retain original formatting of table as provided)
6 125             | 273                | 01        | 23400
0 000             | 061                | 30        | 13011
0 000             | 612                | 61        | 25211

If possible, explain how addresses given below (in octal) will be translated and provide the requested translated address. If a translation is not possible, explain what will happen and why. Show and explain how you derived your answer. Express the all physical address using all 33-bits and all virtual addresses using all 39-bits.
a.(3 mark(s)) The physical address that results from a load from virtual address = 6 125 273 127 604

b.(3 mark(s)) The physical address that results from a store to virtual address = 0 000 061 252 127.

c.(3 mark(s)) Can a store be performed on the physical address = 61 252 612 522? If yes, provide the virtual address used to access this physical address and if not explain precisely why not.
```json
{
  "problem_id": "6",
  "points": 9,
  "type": "Freeform",
  "tags": ["tlb","address-translation","virtual-memory"],
  "answer": "THIS DOES NOT NEED TO BE STATED OR REPEATED FOR EACH PART.\n$a.$ The physical address that results from a load from virtual address = 6 125 273 127 604:\nTHIS DOES NOT NEED TO BE STATED OR REPEATED FOR EACH PART.\n$2^{18}$ = 256 KB so 18 bits for offset. 39-18 = 21 for VPN.\n18 bits = 6 octal characters for offset, 21 bits = 7 octal characters for VPN.\nSo the first 7 octal characters are the VPN and the last 6 are the offset.\n612 5273 | 127 604\nlookup 612 5273 in TLB valid bit is NOT set so exception.\n\nb.$ The physical address that results from a store to virtual address = 0 000 061 252 127.\n0 000 061 | 252 127.\n0 000 061 is in the TLB and is valid and can be dirtied so translation occurs.\nResulting frame is 30 130.\nSo resulting address is 30 130 252 127.\n\nc.$ Can a store be performed on thephysicaladdress = 61 252 612 522 If yes, provide the\nvirtual address used to access this physical address and if not explain precisely why not.\nPart of the solution: 61 252 612 522 frame is 61 252 which is found in the TLB.\nThe page can be written and is valid so a translation occurs.\nThe corresponding page is 0 000 612 so we get the virtual address\n0 000 612 612 522",
  "llm_judge_instructions": "Award up to 9 points total across parts a, b, c for correct translations and explanations. 3 points per part if fully correct; partial credit if partially correct."
}
```

---

## Question 5 [9 point(s)]

Problem 7 (9 marks)
Note: to make some numbers easier to read, spaces have been added between every 4 hexadecimal characters. Please also use this convention when providing your answers.
The structure addrspace shown below describes the address space of a running process on a slightly modified MIPS processor. The addrspace and modified processor are similar to the dumbvm and MIPS processor provided in OS161/SYS161. The key differences are that this processor uses 36-bit virtual and physical addresses and a page size of 64 KB (0x1 0000). In a similar fashion to the 32-bit MIPS OS/161 processor the 36-bit virtual address space on this modified processor is divided into two halves. Virtual addresses from 0 to 0x7 FFFF FFFF are for user programs and virtual address from 0x8 0000 0000 to 0xF FFFF FFFF can not be accessed while in user mode. Fortunately, this new version of the OS161 kernel now explicitly represents the stack as segment 3 (note the stack size).
struct addrspace {
vaddr_t as_vbase1 = 0x0 5000 0000;      /* text segment: virtual base address */
paddr_t as_pbase1 = 0x0 0010 0000;      /* text segment: physical base address */
size_t as_npages1 = 0x200;              /* text segment: number of pages */
vaddr_t as_vbase2 = 0x3 0000 0000;      /* data segment: virtual base address */
paddr_t as_pbase2 = 0x8 0000 0000;      /* data segment: physical base address */
size_t as_npages2 = 0x137;              /* data segment: number of pages */
vaddr_t as_vbase3 = 0x4 0000 0000;      /* stack segment: virtual base address */
paddr_t as_pbase3 = 0x1 0000 0000;      /* stack segment: physical base address */
size_t as_npages3 = 0x18;               /* stack segment: number of pages */
};
For an application executing in user space that uses the address space defined above, assume that it is accessing the specified addresses below. When possible you are to translate the provided address. If the translation is not possible, explain why it is not possible and what would happen during translation. If the translation is possible provide the requested translated address and indicate which segment the address belongs to. Use hexadecimal notation for all addresses and show all 36-bits. Show and explain how you arrived at your result.
Some possibly useful values:
1 * 64 KB =  0x1 * 0x1 0000 =  0x1 0000    2 * 64 KB =  0x2 * 0x1 0000 = 0x2 0000
10 * 64 KB = 0xA * 0x1 0000 = 0xA 0000   16 * 64 KB = 0x10 * 0x1 0000 = 0x10 0000
32 * 64 KB = 0x20 * 0x1 0000 = 0x20 0000
a.(3 mark(s)) Translate the Virtual Address 0x4 0017 6429 to a Physical Address.

b.(3 mark(s)) Translate the Virtual Address 0x0 5200 AB25 to a Physical Address.

c.(3 mark(s)) If possible, determine the user space Virtual Address that could be used to access the Physical Address 0x8 0128 95FA.
```json
{
  "problem_id": "7",
  "points": 9,
  "type": "Freeform",
  "tags": ["address-space","virtual-memory","mips"],
  "answer": "Part of the stack segment.\n0x4 0017 6429 - 0x4 0000 0000 = 0x17 6429 (this is < 0x18 pages, 0x18 0000)\nSo 0x17 6429 + 0x1 0000 0000 = 0x1 0017 6429\n\nb.(3 mark(s))Translate theVirtualAddress0x0 5200 AB25to aPhysicalAddress.\n\nNo translation. This is not part of ANY segment.\nCOMMON MISTAKE: saying it is part of text segment but is out ofrange of that segment.\nOr only that it is not part of the text segment, that is insufficient.\nIt must not be part of ANY segment.\n\nc.(3 mark(s))If possible, determine the user spaceVirtualAddress that could be used to access the\nPhysicalAddress0x8 0128 95FA.\n\nPart of the data segment.\n0x8 0128 95FA - 0x8 0000 0000 = 0x128 95FA (0x128 95FA < 0x137 pages = 0x137 0000).\nSo 0x128 95FA + 0x3 0000 0000 = 0x3 0128 95FA.",
  "llm_judge_instructions": "Award up to 9 points total across parts a, b, c for correct translations and segment identification. Partial credit allowed."
}
```