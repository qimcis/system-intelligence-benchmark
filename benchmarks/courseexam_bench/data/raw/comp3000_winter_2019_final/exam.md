# COMP 3000 Winter 2019 Final

```json
{
  "exam_id": "comp3000_winter_2019_final",
  "test_paper_name": "COMP 3000 Winter 2019 Final",
  "course": "COMP3000",
  "institution": "Carleton University",
  "year": 2019,
  "score_total": 52,
  "num_questions": 26
}
```

---

## Question 1 [2 point(s)]

Does execve close files that were previously open? How do you know?

```json
{
  "problem_id": "1",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "execve does not close files that were previously open.",
  "llm_judge_instructions": "Award 2 points for correctly stating that execve does not close files that were previously open. Award 0 points otherwise."
}
```

---

## Question 2 [2 point(s)]

When does a call to wait return immediately? What does wait return?

```json
{
  "problem_id": "2",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "It returns immediately when a child process has already terminated. Wait returns the PID of the exited process and its exit status.",
  "llm_judge_instructions": "Award 2 points for stating that wait returns immediately if a child has terminated and returns the PID and exit status of that child. 0 points otherwise."
}
```

---

## Question 3 [2 point(s)]

If your program has the following code, what could it potentially output (depending upon the state of the system)? Assume you are running this as the user student.

execve("/usr/bin/whoami", argv, NULL);
printf("Done!\n");

```json
{
  "problem_id": "3",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "\"student\" or \"Done!\"",
  "llm_judge_instructions": "Award 2 points if the answer states that the program could output either 'student' or 'Done!' depending on whether whoami exists and is executable. 0 points otherwise."
}
```

---

## Question 4 [2 point(s)]

What is stored in the numeric directories in /proc? And, what is stored in the comm file in each of these numeric directories?

```json
{
  "problem_id": "4",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "The kernel information on each process is stored in /proc/[pid]; the comm file contains the short name of the executable for that process.",
  "llm_judge_instructions": "Award 2 points for noting that /proc/[pid] contains per-process kernel information and that comm holds the short executable name. 0 points otherwise."
}
```

---

## Question 5 [2 point(s)]

What is the PATH environment variable used for? Why is this variable used (rather than a process getting this information from another source)?

```json
{
  "problem_id": "5",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "PATH stores directories to search for executables; using PATH avoids the shell searching the entire filesystem and potentially untrusted directories.",
  "llm_judge_instructions": "Award 2 points for stating that PATH lists directories to search for executables and that it avoids scanning the whole filesystem or untrusted directories. 0 points otherwise."
}
```

---

## Question 6 [2 point(s)]

Is stack allocation of variables more or less efficient than heap allocation? Specifically, which requires more instructions and system calls? Explain briefly.

```json
{
  "problem_id": "6",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Stack allocation is more efficient; heap allocation requires system calls.",
  "llm_judge_instructions": "Award 2 points for stating that stack allocation is more efficient and that heap allocation entails system calls. 0 points otherwise."
}
```

---

## Question 7 [2 point(s)]

You’re working on a Linux system where the setuid permission bit is ignored. What kinds of programs will break, and is this breakage significant?

```json
{
  "problem_id": "7",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Programs that are run by the user but need root privileges, such as passwd and fusermount; such breakage prevents privileged tasks from users, which is significant.",
  "llm_judge_instructions": "Award 2 points for identifying at least one setuid program and explaining the resulting problems; 0 points otherwise."
}
```

---

## Question 8 [2 point(s)]

What happens when you mount a filesystem on a non-empty directory? Specifically, is any data lost or deleted when this happens? Explain briefly.

```json
{
  "problem_id": "8",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "No data is lost; the existing files are hidden by the new filesystem until unmount, at which point the old files reappear.",
  "llm_judge_instructions": "Award 2 points for stating that no data is lost, that existing files are hidden, and that they reappear after unmount. 0 points otherwise."
}
```

---

## Question 9 [2 point(s)]

Can signal handlers produce race conditions? How? Assume that the process is single-threaded (i.e., is a standard Linux process).

```json
{
  "problem_id": "9",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Yes; by modifying data structures that the main code also uses; issues arise with non-reentrant functions.",
  "llm_judge_instructions": "Award 2 points for explaining that signal handlers can race with main code by accessing shared data and mentioning non-reentrancy. 0 points otherwise."
}
```

---

## Question 10 [2 point(s)]

Do you think a symbolic link can refer to a file on another filesystem? What about hard links? Explain briefly.

```json
{
  "problem_id": "10",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Symbolic links can refer to any file; hard links are limited to the same filesystem because they reference inodes.",
  "llm_judge_instructions": "Award 2 points for stating symbolic links can reference across filesystems and hard links cannot due to inodes. 0 points otherwise."
}
```

---

## Question 11 [2 point(s)]

Why does fsck (on a non-journaled filesystem) have to walk through the entire filesystem hierarchy and inode table? Give an example of one specific error it could find.

```json
{
  "problem_id": "11",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "To check for inconsistencies, especially reference counts; e.g., a file with refcount 2 but only one directory entry references it.",
  "llm_judge_instructions": "Award 2 points for identifying the need to check reference counts and providing a concrete example like mismatched reference counts. 0 points otherwise."
}
```

---

## Question 12 [2 point(s)]

Why is it important for file copying programs on Linux to treat sparse files differently? What problem can arise if sparse files are treated like regular files? And does this same problem apply to backup programs that compress their output?

```json
{
  "problem_id": "12",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Copying sparse files like regular files can allocate blocks for zero regions; backups that compress can mitigate this but restoration may inflate size.",
  "llm_judge_instructions": "Award 2 points for noting the potential space inefficiency when copying sparse files and mention that backups can compress sparse regions; 0 points otherwise."
}
```

---

## Question 13 [2 point(s)]

When a process exits, does the kernel automatically reclaim the memory resources it was using? What about when a kernel module exits, is memory reclaimed? Explain briefly.

```json
{
  "problem_id": "13",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Yes; the kernel reclaims a process's memory. Kernel modules do not have their memory automatically reclaimed when the module exits.",
  "llm_judge_instructions": "Award 2 points for stating process memory is reclaimed and module memory is not automatically reclaimed. 0 points otherwise."
}
```

---

## Question 14 [2 point(s)]

When a system call encounters an error (such as an invalid argument), how does it return an error to userspace? And, how does userspace receive this error? Explain briefly.

```json
{
  "problem_id": "14",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "The kernel returns a negative error code as the system call’s return value; userspace sees it in errno.",
  "llm_judge_instructions": "Award 2 points for describing negative error code return and errno in userspace. 0 points otherwise."
}
```

---

## Question 15 [2 point(s)]

The functions remember read() and remember write() have an offset argument that is a pointer to lofft. The read and write system calls, however, do not have offsets in their arguments. From the perspective of userspace, where is the offset stored? What about from kernel space?

```json
{
  "problem_id": "15",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Userspace offsets are implicit in the open file (via the file descriptor). In kernel space the offset is stored as part of the FILE struct.",
  "llm_judge_instructions": "Award 2 points for correctly stating the userspace implicit offset via file descriptor and kernel-space offset in the file structure. 0 points otherwise."
}
```

---

## Question 16 [2 point(s)]

In the remember module, saved data orderspecified the size of the static buffer. This variable does not specify the number of bytes to allocate (as you would with a call to malloc). What does it specify instead? Why is this different?

```json
{
  "problem_id": "16",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "It specifies the number of pages to allocate as a power of two (order). This minimizes external fragmentation.",
  "llm_judge_instructions": "Award 2 points for stating that it specifies page order (power-of-two pages) and noting fragmentation implications. 0 points otherwise."
}
```

---

## Question 17 [2 point(s)]

The remember module code does not enforce mutual exclusion on the saved data buffer. How could you enforce mutual exclusion? What would be the potential benefit of doing so?

```json
{
  "problem_id": "17",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Add a semaphore (e.g., a spinlock) to guard access to the buffer; it prevents concurrent writes/reads and avoids undefined behavior.",
  "llm_judge_instructions": "Award 2 points for proposing a synchronization primitive (semaphore/spinlock) and explaining the benefit of preventing concurrent access. 0 points otherwise."
}
```

---

## Question 18 [2 point(s)]

How can programs such as bashreadline observe the detailed behavior of large numbers of processes? Specifically, what is the key difference between bashreadline and other monitoring tools (such as ps), and why is this difference significant?

```json
{
  "problem_id": "18",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "bashreadline uploads eBPF bytecode into the kernel for deeper monitoring; ps only reads /proc. This enables deeper access to process and kernel state.",
  "llm_judge_instructions": "Award 2 points for mentioning eBPF-based monitoring and contrast with ps. 0 points otherwise."
}
```

---

## Question 19 [2 point(s)]

When does the producer sleep in3000pc? Is this sleep essential for 3000pc to work, or is it simply there to improve performance? Explain briefly.

```json
{
  "problem_id": "19",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "The producer sleeps when the queue is full; this sleep is essential to avoid busy-waiting, not just for performance.",
  "llm_judge_instructions": "Award 2 points for stating the sleep occurs when the queue is full and that it prevents busy-waiting; 0 points otherwise."
}
```

---

## Question 20 [2 point(s)]

What’s the difference between a regular mmap and an anonymous mmap? Why would you use one rather than the other?

```json
{
  "problem_id": "20",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Regular mmap maps a file into memory; anonymous mmap maps memory without a file. Use when you need file-backed memory vs. pure memory.",
  "llm_judge_instructions": "Award 2 points for distinguishing file-backed mmap vs anonymous mmap and giving use-case rationale. 0 points otherwise."
}
```

---

## Question 21 [2 point(s)]

The Linux kernel’s random number generator combines data gathered from multiple drivers in the kernel with a cryptographically secure pseudorandom number generator. Why must both of these components be used? (Note that the standard Crand()uses neither of these.)

```json
{
  "problem_id": "21",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Driver gathering provides base entropy; the cryptographic PRNG makes the output unbiased and unpredictable.",
  "llm_judge_instructions": "Award 2 points for noting base entropy from drivers and unbiased unpredictable output from the PRNG. 0 points otherwise."
}
```

---

## Question 22 [2 point(s)]

Why do processes have a uid and an euid? Why not just use uid?

```json
{
  "problem_id": "22",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "euid is used for permission checks; uid identifies the owning user. They differ due to setuid programs.",
  "llm_judge_instructions": "Award 2 points for explaining the distinction and the need for setuid. 0 points otherwise."
}
```

---

## Question 23 [2 point(s)]

Why can it be hard to find race condition vulnerabilities? Explain with an example.

```json
{
  "problem_id": "23",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Race conditions often require very specific timing; TOCTTOU is an example where vulnerability only manifests under rare scheduling conditions.",
  "llm_judge_instructions": "Award 2 points for noting rarity/timing sensitivity and giving TOCTTOU as an example. 0 points otherwise."
}
```

---

## Question 24 [2 point(s)]

Eve wants to rewrite the semaphore implementation in the thread library she is using because she finds the code ugly and hard to follow. You are Eve’s boss. Eve is a very talented but junior developer. What do you tell Eve?

```json
{
  "problem_id": "24",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "No; do not rewrite semaphores. They are complex and error-prone; study existing implementations first. If changes are needed, proceed cautiously.",
  "llm_judge_instructions": "Award 2 points for advising against self-implementation and suggesting study and careful approach. 0 points otherwise."
}
```

---

## Question 25 [2 point(s)]

Alice wants to develop a security-related Linux kernel module. This module needs to read security policies from files. Bob suggests that she just use standard C library functions such as fopen() and fgets(), since the Linux kernel is written in C. Carol says Alice should instead have a regular process read the files and then write their contents to a character device. Whose advice should Alice follow? Why? (Be sure to analyze the merits of both Bob’s and Carol’s proposal.)

```json
{
  "problem_id": "25",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Alice should follow Carol’s advice. Bob’s approach is invalid because kernel space cannot use standard C library file I/O; reading files from the kernel is problematic. Carol’s approach uses a userspace process to read files and communicates via a device, which is safer and standard.",
  "llm_judge_instructions": "Award 2 points for explaining why kernel space cannot use fopen/fgets and endorsing Carol’s approach, with brief justification. 0 points otherwise."
}
```

---

## Question 26 [2 point(s)]

The Linux kernel supports the signing of kernel modules. When this feature is enabled, only modules that have been properly signed can be loaded. Why would this feature be useful? And, if this was enabled, what information would the kernel need for it to accept a module that you compiled on your own?

```json
{
  "problem_id": "26",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Useful to prevent loading unauthorized modules; the kernel would need the public key(s) used to sign modules to verify signatures.",
  "llm_judge_instructions": "Award 2 points for stating the security benefit and that the kernel needs public keys to verify signatures. 0 points otherwise."
}
```