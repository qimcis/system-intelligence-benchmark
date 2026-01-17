# COMP 3000 Fall 2021 Final

```json
{
  "exam_id": "comp3000_fall_2021_final",
  "test_paper_name": "COMP 3000 Fall 2021 Final",
  "course": "COMP 3000",
  "institution": "Carleton University",
  "year": 2021,
  "score_total": 42,
  "num_questions": 21
}
```

---

## Question 1 [2 point(s)]

How does /dev/null behave like a regular file? How is it different?

```json
{
  "problem_id": "1",
  "points": 2,
  "type": "Freeform",
  "tags": ["unix","filesystem"],
  "answer": "It can be opened, read from, and written to like a regular file, but data written to /dev/null cannot be read back (reads return zero bytes).",
  "llm_judge_instructions": "Award 2 points for stating that /dev/null is writable/readable like a file but reads return end-of-file (no data) when reading; 0 points otherwise."
}
```

---

## Question 2 [2 point(s)]

What is a C statement or declaration that could have generated the following assembly language code? How do you know? Explain briefly.

.LC0:
.string "Hello world!\n"
...
leaq    .LC0(%rip), %rdi
call    puts@PLT

```json
{
  "problem_id": "2",
  "points": 2,
  "type": "Freeform",
  "tags": ["assembly","c-programming"],
  "answer": "A puts(\"Hello world!\\n\"); or printf(\"Hello world\\n\"); could have generated this because the compiler can replace simple printf() calls with puts() ones. .LC0 labels the constant hello world string, and the leaq instruction loads this address into the rdi register, which is used for the first integer/address parameter passed to a function. The call instruction then calls puts(). (Minus half point for saying puts() is a system call.)",
  "llm_judge_instructions": "Award 2 points for a correct explanation connecting the string literal to the call and parameter setup, 1 point for partial reasoning, 0 otherwise."
}
```

---

## Question 3 [2 point(s)]

On x86-64 systems, which is larger, a process’s virtual address space or a host computer’s physical address space? How does this affect which part of a process’s address space can be accessed without generating an error?

```json
{
  "problem_id": "3",
  "points": 2,
  "type": "Freeform",
  "tags": ["virtual-memory","memory-management"],
  "answer": "The virtual address space is much larger than the physical address space, so only a small fraction of the virtual address space can map to allocated physical memory. Accessing parts of the virtual address space that have no corresponding physical page typically generates a fault.",
  "llm_judge_instructions": "Award 2 points for stating the virtual space is larger and explaining that only mapped regions are accessible; 1 point for partial explanation; 0 otherwise."
}
```

---

## Question 4 [2 point(s)]

Describe how environment variable data is arranged in memory. What C data types are used? How are the key-value pairs stored?

```json
{
  "problem_id": "4",
  "points": 2,
  "type": "Freeform",
  "tags": ["environment-variables","memory-layout"],
  "answer": "Environment variables are organized as an array of pointers to null-terminated strings; the array of pointers is NULL-terminated. Each string contains the VARIABLE=VALUE pair, with the value terminated by a null byte.",
  "llm_judge_instructions": "Award 2 points for describing the array of string pointers ending with NULL and each string containing KEY=VALUE with a terminating null. 1 point for partial description. 0 otherwise."
}
```

---

## Question 5 [2 point(s)]

You’re writing a program on a new version of Linux that has a new system call, fastread. Libraries have not been updated to support fastread. Can you make a pure, standards-compliant C program that calls the fastread system call? Why or why not?

```json
{
  "problem_id": "5",
  "points": 2,
  "type": "Freeform",
  "tags": ["system-calls","linux"],
  "answer": "You can’t make a standards-compliant C program because calling system calls requires using platform-specific code (i.e., special assembly language instructions). You have to use inline assembly or a function that has inline assembly (i.e., syscall()).",
  "llm_judge_instructions": "Award 2 points for noting the need for non-portable, platform-specific mechanisms; 1 point for partial justification; 0 otherwise."
}
```

---

## Question 6 [2 point(s)]

Which is bigger on disk, a statically-linked binary or a dynamically-linked binary? Why?

```json
{
  "problem_id": "6",
  "points": 2,
  "type": "Freeform",
  "tags": ["linking","binaries"],
  "answer": "Statically linked binaries are bigger on disk because they include all library code. Dynamically linked binaries rely on shared libraries loaded at runtime, reducing the binary size.",
  "llm_judge_instructions": "Award 2 points for the correct reasoning about static vs dynamic linking; 0 otherwise."
}
```

---

## Question 7 [2 point(s)]

In the Microsoft Win32 API, theCreateFile()call is used to open a new or existing file. It returns an object handle (a pointer to a pointer that then refers to the object). What is the Linux system call equivalent to this? What is the type of its return value?

```json
{
  "problem_id": "7",
  "points": 2,
  "type": "Freeform",
  "tags": ["linux","open","file-descriptors"],
  "answer": "The Linux equivalent is open, and it returns a file handle, which is an integer.",
  "llm_judge_instructions": "Award 2 points for identifying open and an integer file descriptor; 1 point for partial; 0 otherwise."
}
```

---

## Question 8 [2 point(s)]

When process A writes to a an existing file X, it freezes/locks up. Why could this happen? How could you get A to continue running? Assume that writes to most other files (new and old) work as expected.

```json
{
  "problem_id": "8",
  "points": 2,
  "type": "Freeform",
  "tags": ["file-systems","pipes"],
  "answer": "The file could be a named pipe, and the way to fix it would be for another process to read from the pipe.",
  "llm_judge_instructions": "Award 2 points for identifying a named pipe as the cause and the need for a reader; 1 point for partial; 0 otherwise."
}
```

---

## Question 9 [2 point(s)]

What is the purpose ofqueue nonfullin Tutorial 8’s 3000pc-rendezvous-timeout.c? Explain how it is being used in every place it is accessed in the program, outside of its initialization.

```json
{
  "problem_id": "9",
  "points": 2,
  "type": "Freeform",
  "tags": ["threads","condition-variables","producer-consumer"],
  "answer": "Its purpose is to allow the consumer to wake up the producer after the producer has gone to sleep. The producer sleeps when the queue is full; the consumer signals to wake it up.",
  "llm_judge_instructions": "Award 2 points for explaining wake-up signaling via condition variable when queue is full; 1 point for partial explanation; 0 otherwise."
}
```

---

## Question 10 [2 point(s)]

What part of3000makefs.sh(from Assignment 3) is necessary to allow ps to work correctly? Why?

```json
{
  "problem_id": "10",
  "points": 2,
  "type": "Freeform",
  "tags": ["procfs","ps"],
  "answer": "Line 58, the mounting of /proc, is necessary for ps to work because ps looks in /proc to get information on running processes.",
  "llm_judge_instructions": "Award 2 points for mentioning /proc is mounted; 1 point for partial mention; 0 otherwise."
}
```

---

## Question 11 [2 point(s)]

In the chrooted environment created by3000makefs.sh, doeslsdepend on any dynamically linked libraries? Explain.

```json
{
  "problem_id": "11",
  "points": 2,
  "type": "Freeform",
  "tags": ["chroot","busybox"],
  "answer": "No, because it is part of busybox, and busybox is statically linked.",
  "llm_judge_instructions": "Award 2 points for stating static linking of busybox; 0 otherwise."
}
```

---

## Question 12 [2 point(s)]

Can a mount command increase the space available for storing files? Explain.  (Be sure to consider uses beyond those in3000makefs.sh.)

```json
{
  "problem_id": "12",
  "points": 2,
  "type": "Freeform",
  "tags": ["mount","filesystems"],
  "answer": "Yes, because you can mount a filesystem on an additional device, such as a USB stick. This storage thus becomes available to files created under the mountpoint.",
  "llm_judge_instructions": "Award 2 points for recognizing mounting a new filesystem adds accessible space; 0 otherwise."
}
```

---

## Question 13 [2 point(s)]

On the class VM, what files have to be changed in order to add a new user? What about to add a group?

```json
{
  "problem_id": "13",
  "points": 2,
  "type": "Freeform",
  "tags": ["linux-users","passwd","group"],
  "answer": "You change /etc/passwd and /etc/shadow to add a new user, and /etc/group and /etc/gshadow to add a group.",
  "llm_judge_instructions": "Award 2 points for listing all four files with appropriate roles; 1 point for partial listing; 0 otherwise."
}
```

---

## Question 14 [2 point(s)]

3000shellcan make many stat system calls for every command entered. Which function makes these stat calls? What are these stat calls for?

```json
{
  "problem_id": "14",
  "points": 2,
  "type": "Freeform",
  "tags": ["stat","filesystem"],
  "answer": "find binary() makes these calls (on line 124). They check whether the constructed absolute filename actually exists or not, thus telling us whether we’ve found the executable we are looking for.",
  "llm_judge_instructions": "Award 2 points for identifying the function and its purpose; 1 point for partial; 0 otherwise."
}
```

---

## Question 15 [2 point(s)]

If you do a printf() that does not end in a newline, it will not be immediately output to a terminal; instead, it will only be output later once a newline is output. How can you force terminal output without a newline? Why does this work?

```json
{
  "problem_id": "15",
  "points": 2,
  "type": "Freeform",
  "tags": ["stdio","stdout"],
  "answer": "You can force output with fflush(), because C library functions such as printf() do buffered output to terminals and so only issue write system calls when their buffer is filled, a newline is output, or the buffer is flushed.",
  "llm_judge_instructions": "Award 2 points for mentioning fflush() and the reason about buffering; 0 otherwise."
}
```

---

## Question 16 [2 point(s)]

What is the relationship between sigaction() and kill()?

```json
{
  "problem_id": "16",
  "points": 2,
  "type": "Freeform",
  "tags": ["signals"],
  "answer": "sigaction() is used to register signal handlers which are run when a process receives a signal. kill() is used to send signals.",
  "llm_judge_instructions": "Award 2 points for correctly stating roles of registration vs sending; 0 otherwise."
}
```

---

## Question 17 [2 point(s)]

Tools likegdbandstrace, that use the ptrace system call, have several significant limitations compared t obpftraceand other tools based on eBPF. What is one thing you can do with eBPF that you can’t do with ptrace? And, what key restriction is placed on eBPF programs that isn’t there for ptrace programs?

```json
{
  "problem_id": "17",
  "points": 2,
  "type": "Freeform",
  "tags": ["ebpf","ptrace","performance-monitoring"],
  "answer": "With eBPF you can observe all the processes on the system and change how the kernel works, potentially modifying security or scheduling decisions; ptrace can only observe one process at a time. eBPF programs must be loaded and run as root however.",
  "llm_judge_instructions": "Award 2 points for describing system-wide observation and kernel interaction with root requirement; 1 point for partial; 0 otherwise."
}
```

---

## Question 18 [2 point(s)]

What is one signal that can be sent directly from one process to another (via the kernel)? What is another signal that is sent by the kernel itself and received by a process? Briefly explain the purpose of each signal.

```json
{
  "problem_id": "18",
  "points": 2,
  "type": "Freeform",
  "tags": ["signals","kernel"],
  "answer": "Common ones are SIGTERM, SIGKILL, and SIGSTOP for sending from one process to another. SIGSEGV, SIGBUS, SIGCHLD etc. are sent by the kernel to a process.",
  "llm_judge_instructions": "Award 2 points for correctly identifying one process-to-process signal and one kernel-sent signal with brief purposes; 0 otherwise."
}
```

---

## Question 19 [2 point(s)]

Could you make a special file that, when read, returns a random sentence? Why or why not? Be sure to explain how it could be done or why it would be impossible. (No code is required in your answer.)

```json
{
  "problem_id": "19",
  "points": 2,
  "type": "Freeform",
  "tags": ["kernel-modules","character-device"],
  "answer": "Yes you could, it would just be a kernel module like newgetpid, but it would choose a random sentence from a built-in database (or perhaps load it previously) and then return it. It is a character device because input and output can be arbitrarily sized; read/write could support streaming.",
  "llm_judge_instructions": "Award 2 points for describing a kernel module/character device approach; 0 otherwise."
}
```

---

## Question 20 [2 point(s)]

After loading the ones module from Tutorial 7, running “cat /dev/ones” will produce an unbounded sequence of 1’s. How is this possible, given that ones read() only outputs a limited number of 1’s? Explain briefly.

```json
{
  "problem_id": "20",
  "points": 2,
  "type": "Freeform",
  "tags": ["devices","kernel-module"],
  "answer": "On every read, it will fill the given buffer completely and return the size of the buffer as the number of characters read. Thus there’s never any indication of end of file (and indeed the offset is never changed), so subsequent reads will be indicated and will return the same, thus producing unbounded output.",
  "llm_judge_instructions": "Award 2 points for describing buffer-filled reads and persistent offset behavior; 0 otherwise."
}
```

---

## Question 21 [2 point(s)]

If the kernel accesses a process’s data using standard C methods, such as dereferencing a pointer, it can result in errors. Why? How can it access process data safely?

```json
{
  "problem_id": "21",
  "points": 2,
  "type": "Freeform",
  "tags": ["kernel-space","user-space","pointers"],
  "answer": "User data is in a process with its own address space separate from the kernel (in most architectures), so user-space pointers aren’t valid in the kernel context. The kernel uses safe accessors like get_user()/put_user() to translate or validate addresses.",
  "llm_judge_instructions": "Award 2 points for explaining separate address spaces and use of get_user/put_user; 0 otherwise."
}
```

---