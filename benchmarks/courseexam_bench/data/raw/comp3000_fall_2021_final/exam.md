# COMP 3000 Fall 2021 Final Exam

```json
{
  "exam_id": "comp3000_fall_2021_final",
  "test_paper_name": "COMP 3000 Fall 2021 Final Exam",
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
  "tags": ["operating-systems"],
  "answer": "You can open, read from, and write to it, just like a regular file.  Unlike a regular file, data written cannot be read back, as reads always return nothing (a read of zero bytes).",
  "llm_judge_instructions": "Award full points for noting that /dev/null discards written data and that reads from /dev/null return zero bytes."
}
```

---

## Question 2 [2 point(s)]

What is a C statement or declaration that could have generated the following assembly language code?
How do you know? Explain briefly.
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
  "tags": ["operating-systems"],
  "answer": "A puts(”Hello world\n”); or printf(”Hello world\n”); could have generated this because the compiler can replace simple printf() calls with puts() ones. .LC0 labels the constant hello world string, and the leaq instruction loads this address into the rdi register, which is used for the first integer/address parameter passed to a function.   The call instruction then calls puts().   (Minus half point for saying puts() is a system call.)",
  "llm_judge_instructions": "Award full points for correctly identifying a simple printf/puts scenario and explanation of the role of .LC0 and leaq in providing the string address to puts()."
}
```

---

## Question 3 [2 point(s)]

On x86-64 systems, which is larger, a process’s virtual address space or a host computer’s physical address space?  How does this affect which part of a process’s address space can be accessed without generating an error?

```json
{
  "problem_id": "3",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "A process’s virtual address space is much larger than the physical address space, because regular computers aren’t close to having 2^64 bytes of RAM. This means that only a small fraction of a process’s (virtual) address space can be accessed without generating an error, because only a small portion can possibly map to allocated physical memory.",
  "llm_judge_instructions": "Award full points for stating the virtual address space is larger and that only a portion mapping to physical memory can be accessed safely."
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
  "tags": ["operating-systems"],
  "answer": "Environment variables are arranged as an array of pointers to arrays of characters, with the array of pointers and each array of characters being null terminated (terminated by a 0 value byte) and the array of string pointers is terminated by NULL (a pointer value of 0).  Each array of characters (each string) contains the name of an environment variable (the key), an equal sign, and the variable’s value, with that value being ended by a null byte.",
  "llm_judge_instructions": "Award full points for describing envp as a null-terminated array of strings in the form KEY=VALUE, with an array terminated by NULL."
}
```

---

## Question 5 [2 point(s)]

You’re writing a program on a new version of Linux that has a new system call,fastread.  Libraries have not been updated to supportfastread.  Can you make a pure, standards-compliant C program that calls thefastreadsystem call? Why or why not?

```json
{
  "problem_id": "5",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "You can’t make a standards-compliant C program because calling system calls requires using platform-specific code (i.e., special assembly language instructions). You have to use inline assembly or a function that has inline assembly (i.e., syscall()).",
  "llm_judge_instructions": "Award full points for noting that standard C does not define a way to invoke non-standard syscalls and that platform-specific mechanisms are required."
}
```

---

## Question 6 [2 point(s)]

Which is biggeron disk, a statically-linked binary or a dynamically-linked binary? Why?
  
```json
{
  "problem_id": "6",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Statically-linked binaries are bigger on disk because they must include all library code in them. Dynamically-linked binaries can load library code at runtime, thus reducing the size of the binary. Libraries do not contain full programs; a program is a self-contained executable that can be run on its own.",
  "llm_judge_instructions": "Award full points for explaining that static linking includes library code, increasing size, while dynamic linking defers library code to runtime."
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
  "tags": ["operating-systems"],
  "answer": "The Linux equivalent is open, and it returns a file handle, which is an integer.",
  "llm_judge_instructions": "Award full points for identifying open as the Linux equivalent and noting that the return value is a file descriptor (an int)."
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
  "tags": ["operating-systems"],
  "answer": "The file could be a named pipe, and the way to fix it would be for another process to read from the pipe.",
  "llm_judge_instructions": "Award full points for identifying a named pipe (FIFO) as a potential blocker and the remedy of another process reading from the pipe."
}
```

---

## Question 9 [2 point(s)]

What is the purpose ofqueue
nonfullin Tutorial 8’s 3000pc-rendezvous-timeout.c? Explain how it is
being used in every place it is accessed in the program, outside of its initialization.

```json
{
  "problem_id": "9",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Its purpose is to allow the consumer to wake up the producer after the producer has gone to sleep. The producer will sleep when the queue is full, meaning there is no room for new production.  On line 163 in pthread condtimedwait() is where the producer sleeps, and line 275 is where the consumer uses this variable to wake up the producer.",
  "llm_judge_instructions": "Award full points for describing the wake-up mechanism between producer and consumer via a full queue and condition variable usage."
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
  "tags": ["operating-systems"],
  "answer": "Line 58, the mounting of /proc, is necessary for ps to work because ps looks in /proc to get information on running processes. (0.5 for saying busybox, 1 for identifying lines for installing busybox such as 56)",
  "llm_judge_instructions": "Award full points for identifying /proc being mounted and its role in procfs access for ps."
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
  "tags": ["operating-systems"],
  "answer": "No, because it is part of busybox, and busybox is statically linked.",
  "llm_judge_instructions": "Award full points for noting static linking of BusyBox in the chroot."
}
```

---

## Question 12 [2 point(s)]

Can a mount command increase the space available for storing files?  Explain.  (Be sure to consider uses beyond those in3000makefs.sh.)

```json
{
  "problem_id": "12",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Yes, because you can mount a filesystem on an additional device, such as a USB stick. This storage thus becomes available to files created under the mountpoint. (Note that storage is filesystem specific, so it won’t make any space available in directories outside of the mountpoint.)",
  "llm_judge_instructions": "Award full points for recognizing that mounting a new filesystem on a device adds space under the mount point."
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
  "tags": ["operating-systems"],
  "answer": "You change /etc/passwd and /etc/shadow to add a new user, and /etc/group and /etc/gshadow to add a group.  (1 point if you identify all four files but don’t distinguish which is for users and which is for groups. No credit for home directory because you could use any directory.)",
  "llm_judge_instructions": "Award full points for naming the four files and distinguishing user vs group files; partial credit for partial identification."
}
```

---

## Question 14 [2 point(s)]

3000shellcan make many stat system calls for every command entered.  Which function makes these stat calls? What are these stat calls for?

```json
{
  "problem_id": "14",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "find\nbinary() makes these calls (on line 124). They check whether the constructed absolute filename actually exists or not, thus telling us whether we’ve found the executable we are looking for.",
  "llm_judge_instructions": "Award full points for identifying the function(s) that perform stat and their purpose to verify executable path existence."
}
```

---

## Question 15 [2 point(s)]

If you do a printf() that does not end in a newline, it will not be immediately output to a terminal; instead, it will only be output later once a newline is output.  How can you force terminal output without a newline? Why does this work?

```json
{
  "problem_id": "15",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "You can force output with fflush(), because C library functions such as printf() do buffered output to terminals and so only issue write system calls when their buffer is filled, a newline is output, or the buffer is flushed.",
  "llm_judge_instructions": "Award full points for mentioning fflush() as the mechanism to flush the C standard I/O buffer."
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
  "tags": ["operating-systems"],
  "answer": "sigaction() is used to register signal handlers which are run when a process receives a signal. kill() is used to send signals.",
  "llm_judge_instructions": "Award full points for describing that sigaction sets up handlers and kill sends signals."
}
```

---

## Question 17 [2 point(s)]

Tools likegdbandstrace, that use the ptrace system call, have several significant limitations compared tobpftraceand other tools based on eBPF.
What is one thing you can do with eBPF that you can’t do with ptrace? And, what key restriction is placed on eBPF programs that isn’t there for ptrace programs?

```json
{
  "problem_id": "17",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "With eBPF you can observe all the processes on the system and change how the kernel works, potentially modifying how security or even scheduling decisions are made; ptrace can only allow one process to be observed at a time. eBPF programs must be loaded and run as root however. (Multiple acceptable answers.)",
  "llm_judge_instructions": "Award full points for noting broader system visibility and kernel interaction with eBPF and the root privileges requirement."
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
  "tags": ["operating-systems"],
  "answer": "Many possible answers.  Common ones are SIGTERM, SIGKILL, and SIGSTOP for sending from one process to another.  SIGSEGV, SIGBUS, SIGCHLD and such are sent by the kernel to a process. (Should also briefly explain each signal.)  (-.5 if two signals that are valid and properly explained but unclear on which is sent by a process vs kernel)",
  "llm_judge_instructions": "Award full points for correctly distinguishing user-sent signals (e.g., SIGTERM) from kernel-sent signals (e.g., SIGCHLD) with a brief purpose description."
}
```

---

## Question 19 [2 point(s)]

Could you make a special file that, when read, returns a random sentence?  Why or why not?  Be sure to explain how it could be done or why it would be impossible. (No code is required in your answer.)

```json
{
  "problem_id": "19",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Yes you could, it would just be a kernel module like newgetpid, but it would choose a random sentence from a built-in database (or perhaps load it previously) and then return it.  (1 for saying yes, 1 for the explanation) Note that character devices are not read or written one character at a time, that would be very wasteful!  It is a character device because input and output can be arbitrarily sized; with block devices, we can only read or write entire blocks (i.e., only 4K at a time).",
  "llm_judge_instructions": "Award full points for outlining a kernel-space approach (e.g., kernel module or character device) and rationale about dynamic sizing vs block reads."
}
```

---

## Question 20 [2 point(s)]

After  loading  theonesmodule  from  Tutorial  7,  running  “cat  /dev/ones”  will  produce  an  unbounded sequence of 1’s.  How is this possible, given that ones read() only outputs a limited number of 1’s?  Explain briefly.

```json
{
  "problem_id": "20",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "On every read, it will fill the given buffer completely and return the size of the buffer as the number of characters read. Thus there’s never any indication of end of file (and indeed the offset is never changed), so subsequent reads will be indicated and will return the same, thus producing unbounded output.",
  "llm_judge_instructions": "Award full points for explaining how repeated reads with a fixed buffer yield unlimited output due to buffering and no EOF."
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
  "tags": ["operating-systems"],
  "answer": "User data is in a process with its own address space separate from the kernel (on most architectures), meaning that userspace pointers simply aren’t valid in the context of the kernel’s own address space. Further, it is possible a userspace pointer is pointing to memory that hasn’t been loaded or isn’t allocated memory; the kernel must check and handle such conditions. To access userspace pointers safely, the kernel uses special functions such as getuser() and putuser() that do the necessary translations. 1 for put/getuser, 1 for different address spaces or something about the difference between memory in userspace and kernelspace.",
  "llm_judge_instructions": "Award full points for recognizing address space separation and the need for special accessors (getuser/putuser) to safely access user memory."
}
```