# CS350 Midterm Spring 2013

```json
{
  "exam_id": "comp_350_spring_2013_midterm",
  "test_paper_name": "CS350 Midterm Spring 2013",
  "course": "COMP 350",
  "institution": "University of Waterloo",
  "year": 2013,
  "score_total": 42,
  "num_questions": 5
}
```

---

## Question 1 [12 Marks]

(a) Explain why registers k0 & k1 cannot be used (even temporarily) by gcc in OS/161.

(b) Explain why there are more registers stored in a trap frame than in a thread context.

(c) True or false: If there are no global variables, then no locks are necessary. Briefly justify.

(d) Give one advantage and one disadvantage of having a software design with high lock granularity (many locks).

(e) Briefly explain what this line of code is doing and why:

mips_syscall(struct trapframe *tf) { 
  ... 
  tf->tf_v0 = retval;       <---- explain this line 
}

(f) Briefly describe why the C stdio library binary is not portable between different operating systems, even on the same hardware (machine architecture).

(g) Explain the primary difference between Hoare semantics and the Mesa semantics used in OS/161.

(h) A system uses a dynamic relocation virtual address scheme. The virtual addresses are 16 bits long, but the relocation register is 32 bits long. What is the maximum amount of physical memory that can be made available to each process? How much physical RAM can the entire system support?

(i) What is the difference between internal and external memory fragmentation?

(j) Explain why dumbvm is more like dynamic relocation than paging.

(k) Give one advantage and one disadvantage of having a small quantum.

(l) Explain the significance of the return value of fork().

---

## Question 2 [6 Marks]

Given the following MIPS 64‐bit TLB entry specification (with 4k page sizes)

VPAGE  bits  44-63  
PFRAME bits  12-31  
DIRTY  bit   10  
VALID  bit    9

and the following TLB entries: (Most Significant Bit on the left)

0x0000 0000 0000 6600  
0x0000 1000 0000 2200  
0x0012 3000 4564 5600  
0x0040 0000 0040 0400  
0x1000 0000 1000 0600

a) For each virtual address below, give the corresponding physical address. If it cannot be determined or a fault would occur reading the address, write “FAULT”.

0x0000 0006  
0x0000 6006  
0x1000 0001  
0x1000 0001  
0x0012 3456  
0x4564 5456  
0x4564 5645  
0x0000 1234  
0x0000 2234  
0x0040 0040  
0x8012 3456

b) For each physical address, provide the corresponding virtual address. If it cannot be determined, write “UNKNOWN”.

0x0000 0006  
0x1000 0001  
0x4564 5645  
0x0040 0040  
0x8012 3456

---

## Question 3 [8 Marks]

(a) [4 Marks] Give a proof as to why resource ordering can prevent deadlocks. It can be informal, but it should be sound. You are not required to reference the deadlock detection algorithm, but you may reference it if you choose.

(b) [4 Marks] Here is Peterson’s algorithm as presented in class:

volatile boolean flag[2]; // initially false  
volatile int turn;  
// for thread A: i = 0 & j = 1, thread B: i = 1 & j = 0

flag[i] = true;  
turn = j;  
while (flag[j] && turn == j) { }  
//critical section  
flag[i] = false;

Your friend has implemented Peterson’s algorithm for OS/161 as follows:  
(He used a thread id tid to identify each thread: tid has the value of either 0 or 1)

turn = 1 - tid;  
flag[tid] = 1;  
while (turn != tid && flag[1 - tid]) { }  
//critical section  
flag[tid] = 0;

Describe how the critical section is protected (or not protected) in this implementation. Justify your answer.

---

## Question 4 [7 Marks]

(a) [2 Marks] Concisely explain how in your A1 cat/mouse solution the decision was made to switch from allowing one animal to eat (ie: cats) to the other animal eating (ie: mice). If you did not complete assignment 1, describe the naïve solution discussed in class.

(b) [1 Mark] Given the above specifications and that (c >> b) and (m >> b), describe any circumstances under which your solution described in a) would achieve its maximum efficiency, and then calculate that efficiency as a formula using the variables c, m, b and t as necessary.

(c) [4 Marks] Given the above specifications, consider the following solution:

“Allow k mice to eat, then allow k cats to eat, and then allow k mice to eat, and so on...”

Determine the efficiency for each scenario below. For each scenario, give the maximum wait time for both cats and mice. The wait time is the amount of time that elapses from when cat X finishes eating, and then cat X starts to eat again. Assume fairness amongst the animals of the same type: once cat X eats, all other cats will eat exactly once before cat X eats again.

[The prompt continues with a table of values in the original; omit the rest for question text.]

---

## Question 5 [9 Marks]

For this problem, you are required to use semaphores to simulate a school cafeteria.

- There are an arbitrary number of students. Each student is a separate thread.
- There is no coordinating or dispatching thread.
- There is an arbitrary number of student threads.
- There are K stations in the cafeteria, numbered 0..K-1 (where K is a global constant).
- Only one student can occupy a station at a time.
- Students may not cut in line or skip a station. They must maintain their original ordering (sequence) and must start at station 0 and finish at station K-1.
- There may be more students than stations, so you must also maintain a queue of students waiting to get to the first station. The following unsynchronized list functions (similar to the linked lists shown in class) should be sufficient. These functions use a (hidden) global variable to store the list structure.
  int is_empty();
  struct student *list_peek_front();
  struct student *list_remove_front();
  void list_append(struct student *s);
- Each student may need more than one food “item” at a station. The number of items student s needs to acquire at station i is s->items[i], which could be zero.
- For each item at station i the student must call: get_item(struct student *s, int i); When the function returns, the student will have the item, but it may block during the function call to wait for the food.
- You must ensure that get_item is synchronized and is never called more than once at the same time for either the same student s or the same station i.
- You may use thread_sleep and thread_wakeup if you wish.

List your global variables and semaphores here. Indicate the initial value of each variable & semaphore.

[Provide your list of global variables and semaphores, and their initial values.]

(You may add fields to struct student if necessary. Provide any helper routines you use and the student thread procedure pseudocode.)

---

## Bonus Question (skipped)