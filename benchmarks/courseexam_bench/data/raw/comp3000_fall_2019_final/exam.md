# COMP 3000A: Operating Systems Fall 2019 Final Exam

```json
{
  "exam_id": "comp3000_fall_2019_final",
  "test_paper_name": "COMP 3000A: Operating Systems Fall 2019 Final Exam",
  "course": "COMP 3000",
  "institution": "University of Carleton",
  "year": 2019,
  "score_total": 60,
  "num_questions": 30
}
```

---

## Question 1 [1 point(s)]

When setting up ssh key-based authentication, what part of the key pair goes in the remote system’s authorized keysfile, the public or private key?

```json
{
  "problem_id": "1",
  "points": 1,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "public",
  "llm_judge_instructions": "Award 1 point if the answer is exactly 'public'."
}
```

---

## Question 2 [1 point(s)]

If you run fsck.ext4 on a damaged ext4 filesystem and it complains that there isn’t an ext4 filesystem to recover, what data is missing?

```json
{
  "problem_id": "2",
  "points": 1,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "primary superblock or all superblocks",
  "llm_judge_instructions": "Award 1 point if the answer exactly matches 'primary superblock or all superblocks'."
}
```

---

## Question 3 [1 point(s)]

Is stack allocation of variables more or less efficient than heap allocation? Specifically, which requires more instructions and system calls?

```json
{
  "problem_id": "3",
  "points": 1,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Stack allocation is more efficient.",
  "llm_judge_instructions": "Award 1 point for the correct statement that stack allocation is more efficient."
}
```

---

## Question 4 [1 point(s)]

When a process exits, does the kernel automatically reclaim the memory resources it was using? How do you know?

```json
{
  "problem_id": "4",
  "points": 1,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Yes. You can tell because even if a program doesn’t free allocated memory, the process’s memory returns to the free memory pool as shown by top.",
  "llm_judge_instructions": "Award 1 point for: (a) stating Yes, and (b) justification that memory is reclaimed back to the free memory pool (e.g., evidenced by tools like top)."
}
```

---

## Question 5 [1 point(s)]

Can a process directly access kernel data structures?

```json
{
  "problem_id": "5",
  "points": 1,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "No. (Virtual memory means each process has its own private memory map, as does the kernel. So no direct access is possible.)",
  "llm_judge_instructions": "Award 1 point for the statement that a user-space process cannot directly access kernel data structures, with the justification about virtual memory separation."
}
```

---

## Question 6 [1 point(s)]

Can a kernel module access all kernel data structures?

```json
{
  "problem_id": "6",
  "points": 1,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Yes (Modules are loaded directly into the kernel and thus occupy part of the kernel’s private virtual address space.)",
  "llm_judge_instructions": "Award 1 point for: (a) yes, and (b) brief justification about modules residing in the kernel space."
}
```

---

## Question 7 [2 point(s)]

When are environment variables initially allocated? What system call causes them to be allocated?

```json
{
  "problem_id": "7",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Environment variables are allocated when a program is loaded into a process, by execve (using its envp parameter).",
  "llm_judge_instructions": "Award 2 points for: (1) recognizing environment variables are allocated at program load time, and (2) naming execve and envp as the mechanism."
}
```

---

## Question 8 [2 point(s)]

To redirect standard input, what must a process do, and how can the process do it?

```json
{
  "problem_id": "8",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "A process must change what file is open on file descriptor 0. One way to do this is to open the desired file and then use dup2 to copy the return file descriptor to fd 0.",
  "llm_judge_instructions": "Award 2 points for: (a) stating redirection targets FD 0, and (b) method using dup2 after opening the target file."
}
```

---

## Question 9 [2 point(s)]

A friend tells you, “A signal handler will only be called while a process is in the middle of a system call. We know this because in 3000shell the only time the signal handler is called is while 3000shell is waiting for input, blocked on a read system call.” Is your friend correct? Explain briefly.

```json
{
  "problem_id": "9",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "The friend is incorrect, as signals can be delivered at any time. The read call in 3000shell is the one that always gets interrupted because 3000shell spends most of its time waiting on user input.",
  "llm_judge_instructions": "Award 2 points for correctly stating that signals can interrupt at any time; provide the rationale referencing the read interruption."
}
```

---

## Question 10 [2 point(s)]

Can the “cd” command be implemented as a separate binary? Explain.

```json
{
  "problem_id": "10",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "The cd command cannot be implented as a separate binary because cd changes the current working directory of a process, and this must be done by a process using the chdir system call. One process cannot call chdir on behalf of another process.",
  "llm_judge_instructions": "Award 2 points for explaining that chdir affects the calling process's working directory and cannot be done by a separate binary."
}
```

---

## Question 11 [2 point(s)]

Do pipes on Linux, such as ls | wc, involve the creation of temporary files? Explain.

```json
{
  "problem_id": "11",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Pipes on Linux do not involve the creation of temporary files; instead, the standard out of the first process (ls) is connect to the standard in of the second process (wc).  (It turns out they are connected using a pipe, see the pipe(2) man page.)",
  "llm_judge_instructions": "Award 2 points for: (a) no temporary files, (b) describe piping between processes."
}
```

---

## Question 12 [2 point(s)]

Are there common situations when you can make a hard link to a file but you cannot make a symbolic link? Explain.

```json
{
  "problem_id": "12",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "There are no common situations where you can make a hard link to a file but cannot make a symbolic link to it. Hard links can normally only be made within the same filesystem while symbolic links can cross filesystem boundaries, referring to any file on the system.",
  "llm_judge_instructions": "Award 2 points for explaining both: hard links limitations (same filesystem) and symbolic links versatility (cross-filesystem)."
}
```

---

## Question 13 [2 point(s)]

On Linux x86-64, are environment variables stored close or far away from program code? How do you know?

```json
{
  "problem_id": "13",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Environment variables are stored for from program code. We can see this if we compare pointers to environment variables to pointers to functions (e.g., envp[0] vs &main). Normally environment variables are near the top of the address space while code in towards the bottom.",
  "llm_judge_instructions": "Award 2 points for noting separation between environment data and code, with pointer-based reasoning."
}
```

---

## Question 14 [2 point(s)]

Say you run the command cp -a A B; rm A; mv B A. Can you tell that A has been replaced with a duplicate, or is the new A indistinguishable from the original A? Explain.

```json
{
  "problem_id": "14",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "The new A will be almost indistinguishable from the original, except that the new one will have a different inode number. This happens because every new file created gets a new inode number, and renaming a file preserves its inode. So the new A will refer to the inode created by cp; the old inode will be freed by the rm command.",
  "llm_judge_instructions": "Award 2 points for describing inode change and renaming semantics accurately."
}
```

---

## Question 15 [2 point(s)]

Assume X and Y are two regular files which have exactly the same size as shown by ls -l. Do X and Y necessarily take up the same number of blocks on disk? Explain.

```json
{
  "problem_id": "15",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "X and Y do not necessarily take up the same number of blocks on disk because one or both could have a hole in it, thus reducing its physical size relative to its logical size. (It is also possible that sizes could vary based on how data from the files were put in blocks, because X and Y were on different filesystems with different block sizes or filesystem layouts, or because the filesystem employed on-the-fly encryption or deduplication.)",
  "llm_judge_instructions": "Award 2 points for mentioning holes, fragmentation, or filesystem differences affecting on-disk blocks."
}
```

---

## Question 16 [2 point(s)]

What do the bs and count parameters to dd specify, in terms of their effect on the read and write system calls emitted byd dd?

```json
{
  "problem_id": "16",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "bs is blocksize, specifies the size of the buffer for reads and writes. Count specifies the number of read and write calls. Example: count=10, bs=512, means 10 reads from input and 10 writes to output, each using a buffer of 512 bytes.",
  "llm_judge_instructions": "Award 2 points for correctly defining bs and count and giving the example interpretation."
}
```

---

## Question 17 [2 point(s)]

If I type sync -a /a/myfiles/ /b/otherfiles/, what have I done to the files in /b/otherfiles/ that were there previously? Explain.

```json
{
  "problem_id": "17",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "If there are files with the same name/path in /b/otherfiles as were in /a/myfiles, those will be updated/overwritten so they are identical to the version in /a/myfiles. The files in otherfiles that aren’t in myfiles, however, will be left unchanged. (To get rid of them, you have to add the –delete and –force options.)",
  "llm_judge_instructions": "Award 2 points for describing overwrite behavior and caveats about non-matching files; mention --delete/--force if possible."
}
```

---

## Question 18 [2 point(s)]

If you know a file’s inode number (for a file on an ext4 filesystem), can you access its contents from user space? What about kernel space?

```json
{
  "problem_id": "18",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "With an inode number only, you can’t access its contents from userspace but you can from kernelspace. There are no system calls that let you open a file using an inode; however, the kernel has to be able to access inodes directly because the kernel implements the entire file and filesystem abstraction, and in fact does so every time a file is opened.",
  "llm_judge_instructions": "Award 2 points for: (a) inode alone cannot be used from user space, (b) kernel-space access via kernel data structures or internal APIs."
}
```

---

## Question 19 [2 point(s)]

Why does the kernel use printk rather than printf? What’s the difference between the two?

```json
{
  "problem_id": "19",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "The kernel uses printk rather than printf because 1) printf goes to standard out, and there is no standard out for the kernel and 2) the kernel doesn’t have access to the standard C library, it has to be self-contained. Instead of going to standard out, printk stores messages in a log buffer that can be retrieved from userspace (by some sort of kernel logging daemon, klogd or systemd’s journal) and/or a terminal device (e.g., the Linux text console or a serial line console).",
  "llm_judge_instructions": "Award 2 points for clearly contrasting printk vs printf and describing where printk logs."
}
```

---

## Question 20 [2 point(s)]

If you upgrade the kernel installed on your system, do you also have to upgrade the modules? Why or why not?

```json
{
  "problem_id": "20",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "You have to upgrade the modules as well. because there is no fixed API between modules and the main kernel. Module code is just kernel code, and thus as internals of the kernel change module behavior also must change. Thus, when you install a new kernel, modules must also be upgraded (recompiled and installed) so they match.",
  "llm_judge_instructions": "Award 2 points for recognizing module compatibility with the kernel and the need to recompile modules."
}
```

---

## Question 21 [2 point(s)]

What are two specific types of information that you get by reading files in /proc and /sys?

```json
{
  "problem_id": "21",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "You can get process information (PIDs, file descriptors, memory maps, owner, group, etc), system information (/proc/cpuinfo, modules and devices in /sys), mounted filesystems, filesystem types available...basically, almost anything about the currently running kernel and its state.",
  "llm_judge_instructions": "Award 2 points for mentioning process info and system/state info accessible via /proc and /sys."
}
```

---

## Question 22 [2 point(s)]

If you wanted to find out what was the user ID associated with a process, what type of data structure would you check? What else does this data structure contain (at a high level)?

```json
{
  "problem_id": "22",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "The kernel stores the user ID in the process's credentials, typically in the task_struct's cred (uid, euid, gid, etc.), which also contains other credentials and capabilities.",
  "llm_judge_instructions": "Award 2 points for mentioning the kernel credential structure (e.g., task_struct with cred) and that it contains uid/euid, gid/eid, capabilities, etc."
}
```

---

## Question 23 [2 point(s)]

Are system calls slower, faster, or the same speed as a function call? Why?

```json
{
  "problem_id": "23",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "System calls are much slower than function calls. While function calls can invoke system calls, a function call on its own is just a few instructions (instructions to put arguments in registers and jump to the function) whereas a system call requires a trap into the kernel and context switching.",
  "llm_judge_instructions": "Award 2 points for noting that system calls are slower and mentioning the trap/context switch overhead."
}
```

---

## Question 24 [2 point(s)]

Are the pages for a process necessarily contiguous in physical memory? What about virtual memory? Contiguous here means the memory addresses form a continuous range, i.e. there are no gaps.

```json
{
  "problem_id": "24",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "Pages for a process are contiguous in virtual memory and are normally not contiguous (and in fact are quite fragmented) in physical memory. The whole purpose of virtual memory is to provide a contiguous, private address space to processes.",
  "llm_judge_instructions": "Award 2 points for describing virtual contiguity and physical fragmentation."
}
```

---

## Question 25 [2 point(s)]

Can the kernel “trust” data passed to it as arguments to system calls? Why or why not? (Explain what you mean by trust.)

```json
{
  "problem_id": "25",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "The kernel cannot trust data passed to it as arguments. The kernel must validate parameters to make sure errors or malicious data do not corrupt or comprompromise the system. (It is true that root users are given more latitute and thus can do more harm to the system than regular users; even for root users that trust has limits, and the kernel verifies things as best it can.)",
  "llm_judge_instructions": "Award 2 points for describing lack of trust and the need for validation; mention trust implications for root vs regular users."
}
```

---

## Question 26 [2 point(s)]

When does a call to wait return immediately? What does wait then return?

```json
{
  "problem_id": "26",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "A call to wait returns immediately when a child process has already terminated or if there are no child processes. If the child process has terminated, it returns with the PID of a child that has exited and its return value is stored in passed-by-reference (pointer) wstatus. If there was no child process, it returns -1.",
  "llm_judge_instructions": "Award 2 points for describing immediate return conditions and the meaning of the returned PID and wstatus."
}
```

---

## Question 27 [2 point(s)]

If your program has the following code, what could it potentially output (depending upon the state of the system)? Assume that this code compiles with no warnings, and assume that you are running this as the user student.

e x e c v e ( ” / u s r / b i n / whoami ” ,   a r g v  ,   NULL ) ;
p r i n t f ( ” Done !\n ” ) ;

```json
{
  "problem_id": "27",
  "points": 2,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "This code either prints “student” or “Done!” to standard out. Only one or the other, never both. This assumes that /usr/bin/whoami, on success, prints out the current user’s username to standard out (as it normally does).",
  "llm_judge_instructions": "Award 2 points for noting the output will be either the username or 'Done!', not both."
}
```

---

## Question 28 [4 point(s)]

What are two specific things you can do with thetrace command (that is part of eBPF)? Can you do these two things withstrace? Explain briefly. (You don’t need to give the precise trace commands.)

```json
{
  "problem_id": "28",
  "points": 4,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "You can do many, many things with trace, and most of those things cannot be done with strace. strace allows you to report on the system calls of a specific process and its children. trace, however, can report on system calls by any process on the system, can report on function calls in processes and in the kernel, can do so selectively (by system call, process, or other criteria), and can report on the kernel and userspace backtrace when those functions are called. For this question, I expected answers such as describing opensnoop and bashreadline (tasks from Tutorial 6) or answers from question 10 on the third assignment.",
  "llm_judge_instructions": "Award 4 points for describing advanced capabilities of trace vs strace, with specific contrasts (global vs per-process, kernel/user-space backtraces, selective tracing)."
}
```

---

## Question 29 [4 point(s)]

What are the four key system calls used when a shell runs an external command? Be sure to consider all processes. Explain the role of each.

```json
{
  "problem_id": "29",
  "points": 4,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "The four key system calls are fork/clone (make a new child process), execve (load the command binary into the child process and run it), exit (the child process terminates with a return value), and wait (get the return value from the child process).",
  "llm_judge_instructions": "Award 4 points for naming the four calls and describing each role briefly."
}
```

---

## Question 30 [4 point(s)]

Outline the basic algorithm for copying a file using mmap. Be sure to specify any key arguments to the necessary system calls.

```json
{
  "problem_id": "30",
  "points": 4,
  "type": "Freeform",
  "tags": ["operating-systems"],
  "answer": "For copying source to dest:\n•a = open(\"source\", O_RDONLY), b = open(\"dest\", O_RDONLY|O_WRONLY|O_CREAT|O_TRUNC)\n•stat(a) to get length of file (len)\n•lseek(b, len-1, SEEK_SET), write one byte\n•s = mmap(a, PROT_READ, MAP_SHARED, len), d = mmap(b, PROT_READ|PROT_WRITE, MAP_SHARED, len)\n•copy len bytes from s to d\n•close(a), close(b)",
  "llm_judge_instructions": "Award 4 points for outlining the mmap-based copy steps clearly, including correct open modes and mmap arguments."
}
```