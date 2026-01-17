# CS 537 Spring 2012 Midterm

```json
{
  "exam_id": "cs537_spring_2012_midterm",
  "test_paper_name": "CS 537 Spring 2012 Midterm",
  "course": "CS 537",
  "institution": "University of Wisconsin-Madison",
  "year": 2012,
  "score_total": 150,
  "num_questions": 15
}
```

---

## Question 1 [10 point(s)]

With the round robin (RR) scheduling policy, a question arises when a new job arrives in the system: should we put the job at the front of the RR queue, or the back? Does this subtle difference make a difference, or does RR behave pretty much the same way either way? (Explain)

Rubric for llm_judge_instructions:
- 0 points: No relevant discussion of queue placement, or only generic statements without connection to RR behavior.
- 4 points: States that RR is time-sliced and rotates; notes that front vs back affects waiting time for the newly arrived job but overall throughput/throughput fairness is largely unchanged in a typical RR, with caveats about starvation for long jobs or interactively arriving short jobs.
- 6 points: Provides a clear analysis of effects on average response time, variance, and potential starvation; discusses how RR's rotation tends to mitigate or amplify these effects depending on how the queue is treated; mentions practical considerations (e.g., implementation detail that may effectively make it similar to back-of-queue in steady state).
- 10 points: Offers a nuanced, well-structured explanation including: how front insertion changes the waiting time distribution for new arrivals, how back insertion can favor fairness across a diverse mix of job lengths, and under what workload characteristics the subtle difference might be negligible vs. significant; includes a concise conclusion about typical RR behavior.

```
{
  "problem_id": "1",
  "points": 10,
  "type": "Freeform",
  "tags": ["operating-systems", "scheduling", "round-robin"]
}
```

---

## Question 2 [10 point(s)]

You write a UNIX shell, but instead of calling fork() then exec() to launch a new job, you instead insert a subtle difference: the code first calls exec() and then calls fork(). What is the impact of this change to the shell, if any? (Explain)

Rubric for llm_judge_instructions:
- 0 points: States nothing meaningful about fork/exec order.
- 5 points: Correctly notes that exec replaces the current process image; after exec, if it succeeds, control does not return to the caller; calling fork() after exec would occur in the new program, not in the shell, so the shell would be replaced and would not spawn a child process as intended.
- 8 points: Adds explanation of what would happen to the original shell process (it would be replaced by the new program; no child process would be created by the shell itself; user commands would not be launched as separate processes in the usual way).
- 10 points: Provides a thorough analysis including potential failure modes (if exec fails, the subsequent fork would still be in the old process, but in practice exec success would destroy the shell), and discusses the broader implications for process hierarchies and job control.

```
{
  "problem_id": "2",
  "points": 10,
  "type": "Freeform",
  "tags": ["unix", "fork-exec", "process-management"]
}
```

---

## Question 3 [10 point(s)]

The multi-level feedback queue policy periodically moves all jobs back to the top-most queue. On a particular system, this is usually done every 10 seconds; the subtle difference we examine is that this value has been shortened to 1 second. How does this subtle difference affect the MLFQ scheduler? In general, what is the effect of shortening this value?

Rubric for llm_judge_instructions:
- 0 points: No relevant discussion.
- 4 points: States that more frequent boosting to the top reduces aging, reduces starvation, and makes behavior closer to RR.
- 6 points: Explains trade-offs: more rapid re-evaluation, increased context switches, possible loss of CPU efficiency, reduced predictability, and how it can erase some benefits of MLFQ (e.g., capturing varying CPU bursts) depending on workload.
- 10 points: Provides a clear, well-justified conclusion: shorter interval tends to increase responsiveness and reduce starvation for short jobs but increases overhead and makes the scheduler behave more like RR; discusses how the choice interacts with aging, fairness, and overall throughput.

```
{
  "problem_id": "3",
  "points": 10,
  "type": "Freeform",
  "tags": ["operating-systems", "scheduling", "mlfq"]
}
```

---

## Question 4 [10 point(s)]

The lottery scheduler relies on random numbers in order to pick the winner of a lottery. This subtly-different lottery scheduler uses a simplified random number generator, which rotates through the following five pseudo-random numbers: 133, 12, 800, 442, 917. How does this change affect the behavior of the lottery scheduler?

Rubric for llm_judge_instructions:
- 0 points: No relevant discussion.
- 4 points: States that using a fixed sequence reduces true randomness and can cause non-uniform or repeatable patterns; some jobs may be effectively favored or disadvantaged.
- 6 points: Explains potential for starvation of low-indexed/low-numbered jobs if the sequence systematically biases win probabilities; notes lack of independence between runs; discusses fairness and predictability.
- 10 points: Provides a thorough assessment: fixed cycle in RNG leads to deterministic but non-uniform selection; explains potential bias and possible remedies (e.g., seeding, more robust RNG); mentions the impact on fairness and system behavior over time.

```
{
  "problem_id": "4",
  "points": 10,
  "type": "Freeform",
  "tags": ["operating-systems", "scheduling", "lottery-scheduler"]
}
```

---

## Question 5 [10 point(s)]

The timer interrupt is a key mechanism used by the OS. Usually, it waits some amount of time (say 10 milliseconds) and then interrupts the CPU. In this subtle difference, the interrupt is not based on time but rather based on the number of TLB misses the CPU encounters; once a certain number of TLB misses take place, the CPU is interrupted and the OS runs. How does this subtle difference affect the timer interrupt and its usefulness?

Rubric for llm_judge_instructions:
- 0 points: No relevant analysis.
- 4 points: Recognizes that the interrupt is not time-based, and that CPU can be monopolized by long-running code with poor locality; repeated misses could cause irregular scheduling.
- 6 points: Explains how this undermines determinism of scheduling and can lead to unpredictable latency, degraded real-time properties, or poor CPU utilization; notes the dependency on memory access patterns.
- 10 points: Provides a thorough critique: non-time-based interrupts break assumptions about periodic progress, may be highly workload-dependent, can be exploited by tight loops with poor cache locality, and generally reduces usefulness for CPU scheduling; discusses potential mitigations or scenarios where it could be acceptable.

```
{
  "problem_id": "5",
  "points": 10,
  "type": "Freeform",
  "tags": ["operating-systems", "interrupts", "virtual-memory", "tlb"]
}
```

---

## Question 6 [5 point(s)]

A TLB often has a valid bit in each entry; the valid bit tells us whether the particular TLB entry should be examined when looking for translations. In this subtle difference, the TLB has no such valid bit. What are the implications of such a difference?

Rubric for llm_judge_instructions:
- 0 points: No relevant discussion.
- 3 points: States that without a valid bit, software must ensure only valid translations are present, or the TLB must be managed more aggressively; risk of using stale or invalid translations.
- 5 points: Clearly describes consequences: harder to distinguish between valid and invalid translations, higher risk of faults, potential need for tighter synchronization with page table updates, and possible performance degradation or correctness issues; mentions maintenance and reliability concerns.

```
{
  "problem_id": "6",
  "points": 5,
  "type": "Freeform",
  "tags": ["virtual-memory", "tlb"]
}
```

---

## Question 7 [10 point(s)]

In a subtly-different system with a software-managed TLB, the OS does not install a translation into the TLB upon the first TLB miss on a particular virtual address. Rather, it increments a counter in the page table entry (PTE). When that counter reaches 3, this subtly-different approach then updates the TLB with the desired translation. How does this lazy TLB update affect the behavior of the system?

Rubric for llm_judge_instructions:
- 0 points: No relevant discussion.
- 4 points: Identifies potential increase in misses on the first accesses but possible reduction in TLB population churn.
- 6 points: Discusses workload dependence: beneficial for programs with good locality and predictable access patterns; detrimental for workloads with sudden jumps or many distinct pages; explains impact on overall memory access latency and TLB refresh rate.
- 10 points: Thorough analysis: explains trade-offs between miss rate, locality, memory access latency, and CPU overhead; discusses how lazy updates can improve cache/TLB locality in some cases but degrade it in others; mentions policy design considerations.

```
{
  "problem_id": "7",
  "points": 10,
  "type": "Freeform",
  "tags": ["virtual-memory", "tlb", "paging"]
}
```

---

## Question 8 [10 point(s)]

With base-and-bounds based virtual memory, two registers (base and bounds) are used to implement a primitive form of virtualization. The subtle change we explore here is to the bounds register. Specifically, in this subtly-different base-and-bounds, the bounds register is checked only on writes to memory, and not on reads from memory. What is the impact of this change?

Rubric for llm_judge_instructions:
- 0 points: No relevant discussion.
- 4 points: States the effect on write protection but not on reads; writes may be constrained but reads could leak memory contents.
- 6 points: Explains security implications: possible memory corruption on writes that go beyond bounds is prevented, but leaks or information exposure could occur on reads; risk to process isolation.
- 10 points: Provides a thorough assessment: writes are prevented from exceeding bounds, but reads can bypass protections, leading to potential data leakage between processes, OS-level invariants being violated, and possible security and stability consequences; discusses potential mitigations and real-world implications.

```
{
  "problem_id": "8",
  "points": 10,
  "type": "Freeform",
  "tags": ["virtual-memory", "memory-protection", "security"]
}
```

---

## Question 9 [10 point(s)]

In a page table, a per-page reference bit is sometimes used to help track which pages are being actively used. A subtle change to the per-page reference bit makes it into a per-page 32-bit counter; when a page is referenced, the corresponding counter is incremented. What is the impact of this change on page replacement within the OS? Can (or should) the OS policy be changed to make use of it?

Rubric for llm_judge_instructions:
- 0 points: No relevant discussion.
- 4 points: Notes increased state requires more storage and management; simple usage like LRU could be approximated with a counter.
- 6 points: Explains potential benefits: more precise usage history enabling better replacement decisions; however, aging and budget of counters; increased overhead.
- 10 points: Thorough analysis: discusses how a 32-bit counter could enable sophisticated usage metrics, can support near-LRU approximations or more elaborate policies (e.g., recency with frequency), potential for improved fault rates; trade-offs include memory overhead, counter overflow handling, OS redesign, and need for policy updates.

```
{
  "problem_id": "9",
  "points": 10,
  "type": "Freeform",
  "tags": ["memory-management", "page-replacement"]
}
```

---

## Question 10 [15 point(s)]

In this subtle difference, we have changed the theme of the exam entirely to allow you to do this one question from the homeworks without any subtle changes at all. It is, of course, the multi-level page table question. Assume (as always) a 15-bit virtual address, with a 32-byte page size, and a two-level page table. The format of both the page directory entry (PDE) and the page table entry (PTE) is the same: a valid bit followed by a 7-bit page frame number. The page directory base register (PDBR) is set to decimal 73. Here is a dump of memory (OK, there is one subtle difference; instead of all of the pages, we only give you the subset of physical memory you need to see):

|pg|6:|a2|e1|0b|1a|19|0a|1a|0c|14|02|0c|10|05|04|0e|3f|17|11|08|05|07|04|13|0e|1d|  
|pg|73:|a2|e2|97|96|e7|84|b7|ef|24|82|7f|be|93|28|99|98|51|7f|20|b8|da|eb|b1|c3|c2|c6|  
|pg|114:|7f|7e|7f|7e|7f|7f|7e|7f|7e|99|7f|7e|7f|7f|88|7e|7f|7e|7e|7f|7e|7e|7f|7e|7f|7e|  

The first virtual address is to translate is 0x1787. What happens when you try to load this virtual address? (if valid, what value do you get back?)

ox1787 => 0 010 [111|000]  
    pg
    5th entry on 
    page 73 => [x7f] Pret=s 
        0l011==>[fault] 

The second virtual address in question is 0x2665. What happens when you try to load it? (if valid, what value do you get back?)  

022665 => 0 1001 10|011|0|1 (02'):5th entry on page 73 03 => 02'15 ef=x f2 f (eN=0010 page 144)
    page 1k)  page 1f9
      | | O>==0  
      A01102A
  144entry  
19thentry on page 114 => Ox ^ 

Rubric for llm_judge_instructions:
- 0 points: No answer.
- 5 points: Provides qualitative reasoning about two-level page table translation; notes the presence of PDE and PTE format, valid bits, and potential fault vs. success; may not provide exact translated addresses due to garbled dump.
- 10 points: Produces a careful explanation of the translation process given the provided PDE/PTE structure, identifies whether each virtual address would fault or translate, and, if translatable, provides the resulting physical address (or clearly explains why it is a fault). Acknowledges any ambiguities due to the garbled dump and states the conclusions based on the given information.

```
{
  "problem_id": "10",
  "points": 15,
  "type": "Freeform",
  "tags": ["virtual-memory", "paging", "two-level-page-table"]
}
```

---

## Question 11 [10 point(s)]

A simple page table entry (PTE) usually contains at least some kind of valid bit followed by the page-frame number. In this subtly-different approach, the order of the two is switched. Thus, the entry contains a PFN followed by a valid bit. Assume the following linear page table for a virtual address space of size 128 bytes with 32-byte pages:

|0x7F=>|111|111|0|not valid|  
|0x0F=>|000|011|1|valid = page|7|    
|0xFE=>| |not valid|    
|0x09=>|0000|010|0|valid = page|4|  

For the following virtual addresses, say whether each is a valid virtual address or a fault; for those that are valid, what physical address results from the translation?

VA 0x065 (decimal: 101) --> ?      [ ]  OX 100 010 1 :::= 32->63  valid on PFN 4 
        06x85=  

VA 0x0Oc (decimal: 12) --> ?  --> Ox 07D          fault  
                                   OxREL    
VA 0x026 (decimal: 38) --> 00 -> [OXE 0 11 11 0 x
                                       0OxM:E&   on PFx  7  OOXE|
                                   |OXM   
                                  
VA 0x058 (decimal: 88) --> 643 fault; orm |] --> trans Actuate Act

```
{
  "problem_id": "11",
  "points": 10,
  "type": "Freeform",
  "tags": ["virtual-memory", "paging", "address-translation"]
}
```

---

## Question 12 [10 point(s)]

Assume we have a system that uses segmentation to provide a virtual memory to processes. Assume the segmentation chops the address space into two parts (segment 0 and 1); segment 0 grows in the increasing direction, while segment 1 grows backwards. Unfortunately, there is confusion over the interpretation of the base register of segment 1; while the hardware thinks it should point to the physical address one beyond the bottom of the backwards-growing segment, the OS has been subtly changed to assume it points to the last byte of the backwards-growing segment. Describe what would happen when running processes on this subtly-changed virtual memory system.

Rubric for llm_judge_instructions:
- 0 points: No answer.
- 3 points: Recognizes misinterpretation leads to potential misaddressing and faults.
- 6 points: Describes how reads and writes could access incorrect memory, possible overlaps, and crashes; mentions direction of growth and boundary interpretation mismatch.
- 10 points: Provides a clear, coherent narrative of chaos, including possible data corruption, crashes, and faulting behavior; discusses possible symptoms and how the OS/hardware mismatch would manifest during program execution.

```
{
  "problem_id": "12",
  "points": 10,
  "type": "Freeform",
  "tags": ["virtual-memory", "segmentation", "memory-protection"]
}
```

---

## Question 13 [10 point(s)]

This code snippet provides a “solution” to the producer/consumer problem, in which a bounded buffer is shared between producer threads and consumer threads. The solution uses a single lock (m) and two condition variables (fill and empty).

Consumer:
while (1) {
    mutex_lock(m);
    if (numfull == 0)
        wait(fill, m);
    tmp = get();
    signal(empty);
    mutex_unlock(m);
}

Producer
for (i = 0; i < 10; i++) {
    mutex_lock(m);
    if (numfull == MAX)
        wait(empty, m);
    put();
    signal(fill);
    mutex_unlock(m);
}

Some subtle changes are made to the condition variable library: wait() is changed so that it never wakes up unless signaled; more importantly, signal() is changed so that it immediately transfers control to a waiting thread (if there is one), thus implicitly passing the lock to the waiting thread as well. Does this subtle change affect the correctness of the producer/consumer solution above? (Describe)

Rubric for llm_judge_instructions:
- 0 points: States nothing about correctness.
- 4 points: Notes potential issue with missing re-check of the condition after wakeup in traditional semantics.
- 6 points: Recognizes that the changed signaling semantics (Hoare-like transfer) can fix or break in different conditions; explains reasoning about whether the waiting thread needs to re-check the condition or can rely on signal semantics.
- 10 points: Provides a clear conclusion: under typical Mesa semantics, you must re-check the condition; with Hoare semantics (immediate transfer), correctness can be achieved with the given code if the wait/signal interactions guarantee the condition holds after wake, but care must be taken to maintain invariants; references to practical semantics (Mesa vs Hoare) and correctness criteria.

```
{
  "problem_id": "13",
  "points": 10,
  "type": "Freeform",
  "tags": ["concurrency", "producer-consumer", "condition-variables"]
}
```

---

## Question 14 [10 point(s)]

A spin lock acquire() can be implemented with an atomic exchange instruction as follows:
while (xchg(&lock, 1) == 1)
; // spin
Recall that xchg() returns the old value at the address while atomically setting it to a new value. This new subtly-different lock acquire() is implemented as follows:

while (1) {
  while (lock > 0)
    ; // spin
  if (xchg(&lock, 1) == 0)
    return;
}

What kind of difference does this new lock make? Does it work? How does it change the behavior of the lock?

Rubric for llm_judge_instructions:
- 0 points: No answer.
- 4 points: Describes that the second variant uses a two-phase approach and may still spin; notes possible issues if lock becomes 0 between checks.
- 6 points: Explains that the inner spin on lock > 0 is a busy wait; the xchg ensures atomic acquisition; may still have race conditions if not properly synchronized; may be a test-and-set style; may be less efficient.
- 10 points: Clear conclusion: The new version is essentially a test-and-test-and-set pattern; it reduces bus traffic by waiting for lock to become 0 before attempting xchg but can cause livelock if contention is high; it does work but with different performance characteristics and potential issues on memory ordering and cache coherency, depending on architecture.

```
{
  "problem_id": "14",
  "points": 10,
  "type": "Freeform",
  "tags": ["concurrency", "locks", "atomic-operations"]
}
```

---

## Question 15 [10 point(s)]

Observe the following multi-thread safe list insertion code:

typedef struct __node_t {
    int              key;
    struct __node_t  *next;
} node_t;

mutex_t m    = PTHREAD_MUTEX_INITIALIZER;
node_t *head = NULL;

int List_Insert(int key) {
    mutex_lock(&m);
    node_t *n = malloc(sizeof(node_t));
    if (n == NULL) { return -1; } // failed to insert
    n->key  = key;
    n->next = head;
    head    = n;                  // insert at head
    mutex_unlock(&m);
    return 0;                     // success!
}

The code has some problems alas. In this final question, you need to insert a subtle change to fix the code and make it work correctly (feel free to augment the code above with your answer).

Rubric for llm_judge_instructions:
- 0 points: No answer.
- 3 points: Points out that in the failure path, the lock is not released before returning.
- 6 points: Proposes to unlock before returning on malloc failure; or restructure to ensure lock is released; or use a more robust memory allocation strategy.
- 10 points: Provides a concrete, minimal fix: insert mutex_unlock(&m); before returning -1 on malloc failure, and discusses ensuring exception-safety, as well as noting potential edge cases (e.g., needs to handle concurrent cleanup if needed). Optionally suggests moving lock/unlock to a narrower scope or using RAII-like pattern if in C++. Also mentions that the critical section should be the shortest possible; and confirms the fix preserves correctness.

```
{
  "problem_id": "15",
  "points": 10,
  "type": "Freeform",
  "tags": ["concurrency", "mutex", "memory-management"]
}
```

---