# CS537: Operating Systems Spring 2018 Final

```json
{
  "exam_id": "cs_537_spring_2018_final",
  "test_paper_name": "CS537: Operating Systems Spring 2018 Final",
  "course": "CS537: Operating Systems",
  "institution": "University of Wisconsin-Madison",
  "year": 2018,
  "score_total": 79,
  "num_questions": 80
}
```

---

## Question 1 [1 point]

For a specific RAID array (call it “RAID A”), a read of a block takes about 10ms. A write of a block 
also takes about 10ms. This RAID is likely:
A) RAID-1 (mirroring)
B) RAID-4 (parity disk)
C) RAID-5 (rotating parity)
D) RAID-4 or RAID-5
E) All of the above

```json
{
  "problem_id": "1",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["operating-systems","raid","storage","forensics"],
  "choices": ["RAID-1 (mirroring)", "RAID-4 (parity disk)", "RAID-5 (rotating parity)", "RAID-4 or RAID-5", "All of the above"],
  "answer": "A"
}
```

---

## Question 2 [1 point]

Question 2: for “RAID B”, two small random writes usually take about twice as long as one random write. This 
RAID is likely:
A) RAID-1 (mirroring)
B) RAID-4 (parity disk)
C) RAID-5 (rotating parity)
D) RAID-4 or RAID-5
E) All of the above

```json
{
  "problem_id": "2",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["operating-systems","raid","storage","forensics"],
  "choices": ["RAID-1 (mirroring)", "RAID-4 (parity disk)", "RAID-5 (rotating parity)", "RAID-4 or RAID-5", "All of the above"],
  "answer": "B"
}
```

---

## Question 3 [1 point]

Question 3: for “RAID C”, a large write (of 7 blocks) usually takes about as much time as a small write (1 
block). This RAID is likely:
A) RAID-1 (mirroring)
B) RAID-4 (parity disk)
C) RAID-5 (rotating parity)
D) RAID-4 or RAID-5
E) All of the above

```json
{
  "problem_id": "3",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["operating-systems","raid","storage","forensics"],
  "choices": ["RAID-1 (mirroring)", "RAID-4 (parity disk)", "RAID-5 (rotating parity)", "RAID-4 or RAID-5", "All of the above"],
  "answer": "D"
}
```

---

## Question 4 [1 point]

Question 4: For “RAID D”, the overall throughput (measured in MB/s) is about 4 MB/s when issuing many 1-
block random writes. In comparison, a comparable RAID array configured to use striping (RAID-0) achieved a 
throughout of about 8 MB/s. This RAID (RAID D) is likely:
A) RAID-1 (mirroring)
B) RAID-4 (parity disk)
C) RAID-5 (rotating parity)
D) RAID-4 or RAID-5
E) All of the above

```json
{
  "problem_id": "4",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["operating-systems","raid","storage","forensics"],
  "choices": ["RAID-1 (mirroring)", "RAID-4 (parity disk)", "RAID-5 (rotating parity)", "RAID-4 or RAID-5", "All of the above"],
  "answer": "A"
}
```

---

## Question 5 [1 point]

Question 5: for “RAID E”, the overall throughput when writing large sequential blocks to disk is about 700 MB/
s. In comparison, large sequential writes to a RAID 0 achieves about 800 MB/s. This RAID (RAID-E) is likely:
A) RAID-1 (mirroring)
B) RAID-4 (parity disk)
C) RAID-5 (rotating parity)
D) RAID-4 or RAID-5
E) All of the above

```json
{
  "problem_id": "5",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["operating-systems","raid","storage","forensics"],
  "choices": ["RAID-1 (mirroring)", "RAID-4 (parity disk)", "RAID-5 (rotating parity)", "RAID-4 or RAID-5", "All of the above"],
  "answer": "D"
}
```

---

## Question 6 [1 point]

For “RAID F”, you know that the RAID is likely RAID-4 or RAID-5. You issue a single perfectly 
aligned block write. The number of physical I/Os you measure on RAID F during this write is:
A) 0
B) 1
C) 2
D) 3
E) 4

```json
{
  "problem_id": "6",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["operating-systems","raid","storage","forensics"],
  "choices": ["0","1","2","3","4"],
  "answer": "B"
}
```

---

## Question 7 [1 point]

For “RAID G”, you have already figured out that it is likely a RAID-1 (mirroring). You then issue a 
single write to the RAID. The write is small (1 block) is aligned. The number of physical I/Os you measure on 
the disks of RAID G is always:
A) 0
B) 1
C) 2
D) Sometimes =2, sometimes >2
E) Always > 2

```json
{
  "problem_id": "7",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["operating-systems","raid","storage","forensics"],
  "choices": ["0","1","2","Sometimes =2, sometimes >2","Always > 2"],
  "answer": "C"
}
```

---

## Question 8 [1 point]

For “RAID H”, you have already figured out that it is likely a RAID-1 (mirroring). You then issue a 
single write to the RAID. The write is small (1 block); however, it is not necessarily aligned. The number of 
physical I/Os you measure on the disks of RAID H is always:
A) 0
B) 1
C) 2
D) Sometimes =2, sometimes >2
E) Always > 2

```json
{
  "problem_id": "8",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["operating-systems","raid","storage","forensics"],
  "choices": ["0","1","2","Sometimes =2, sometimes >2","Always > 2"],
  "answer": "D"
}
```

---

## Question 9 [1 point]

For “RAID I”, you already know that it is RAID-5 (rotating parity). You then issue a single small 
read (1 block), which is never aligned. The number of physical I/Os you measure on the disks of RAID I is 
always:
A) 0
B) 1
C) 2
D) Sometimes =2, sometimes >2
E) Always > 2

```json
{
  "problem_id": "9",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["operating-systems","raid","storage","forensics"],
  "choices": ["0","1","2","Sometimes =2, sometimes >2","Always > 2"],
  "answer": "C"
}
```

---

## Question 10 [1 point]

For “RAID J”, you measure the total number of physical I/Os under a read-only workload. You 
find that it is equal to the number of logical reads issued to the RAID. You also see that one disk is never 
accessed. From this, you conclude that the RAID is:
A) RAID-0 (striping)
B) RAID-1 (mirroring)
C) RAID-4 (parity disk)
D) RAID-0 or RAID-1
E) RAID-0 or RAID-1 or RAID-4

```json
{
  "problem_id": "10",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["operating-systems","raid","storage","forensics"],
  "choices": ["RAID-0 (striping)", "RAID-1 (mirroring)", "RAID-4 (parity disk)", "RAID-0 or RAID-1", "RAID-0 or RAID-1 or RAID-4"],
  "answer": "D"
}
```

---

## Question 11 [1 point]

Assume the STL maps each 4KB block to a location on the disk. How big must the STL be to 
hold translations for an entire 512-GB disk? Assume a 4-byte disk address for each entry in an array-like 
structure in the STL.
A) 1 MB
B) 128 MB
C) 512 MB
D) 1 GB
E) None of the above

```json
{
  "problem_id": "11",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["shingled-disk","storage","forensics"],
  "choices": ["1 MB","128 MB","512 MB","1 GB","None of the above"],
  "answer": "C"
}
```

---

## Question 12 [1 point]

The STL size can be changed by mapping chunks in sizes other than the usual 4KB block. With 
each doubling of the block size, the STL:
A) Increases in size by 2x
B) Decreases in size by 2x
C) Increases in size by 4x
D) Decreases in size by 4x
E) None of the above

```json
{
  "problem_id": "12",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["shingled-disk","storage","forensics"],
  "choices": ["Increases in size by 2x","Decreases in size by 2x","Increases in size by 4x","Decreases in size by 4x","None of the above"],
  "answer": "B"
}
```

---

## Question 13 [1 point]

In a shingled disk, all writes are log-structured. As a result, which of the following is NOT true:
A) Write performance is similar to a regular hard drive for sequential workloads
B) Write performance is similar to a regular hard drive for random workloads
C) Read performance is similar to a regular hard drive for sequential workloads
D) Read performance is similar to a regular hard drive for random workloads
E) All of the above are true

```json
{
  "problem_id": "13",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["shingled-disk","storage","forensics"],
  "choices": ["Write performance is similar to a regular hard drive for sequential workloads","Write performance is similar to a regular hard drive for random workloads","Read performance is similar to a regular hard drive for sequential workloads","Read performance is similar to a regular hard drive for random workloads","All of the above are true"],
  "answer": "B"
}
```

---

## Question 14 [1 point]

The STL size can be changed by mapping chunks in sizes other than the usual 4KB block. With 
each doubling of the block size, the STL:
A) Increases in size by 2x
B) Decreases in size by 2x
C) Increases in size by 4x
D) Decreases in size by 4x
E) None of the above

```json
{
  "problem_id": "14",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["shingled-disk","storage","forensics"],
  "choices": ["Increases in size by 2x","Decreases in size by 2x","Increases in size by 4x","Decreases in size by 4x","None of the above"],
  "answer": "B"
}
```

---

## Question 15 [0 points]

SKIP (accidental repeat)

```json
{
  "problem_id": "15",
  "points": 0,
  "type": "Freeform",
  "tags": ["shingled-disk","forensics"],
  "choices": [],
  "llm_judge_instructions": "This is a placeholder question due to an accidental duplicate in the exam. No answer is required."
}
```

---

## Question 16 [1 point]

In a shingled disk, all writes are log-structured. As a result, which one of the these is NOT true:
A) Performance is similar to a regular hard drive for sequential write workloads
B) Performance is similar to a regular hard drive for random write workloads
C) Performance is similar to a regular hard drive for sequential read workloads
D) Performance is similar to a regular hard drive for random read workloads
E) Performance is similar to a regular hard drive for workloads with a mix of sequential reads/writes

```json
{
  "problem_id": "16",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["shingled-disk","forensics"],
  "choices": ["Performance is similar to a regular hard drive for sequential write workloads","Performance is similar to a regular hard drive for random write workloads","Performance is similar to a regular hard drive for sequential read workloads","Performance is similar to a regular hard drive for random read workloads","Performance is similar to a regular hard drive for workloads with a mix of sequential reads/writes"],
  "answer": "C"
}
```

---

## Question 17 [1 point]

Question 17: Assuming a FIFO scheduling policy, and 
a request stream which reads blocks 21, 17, 11, 7, 13, 
what is the last block to be read?
A) 21
B) 17
C) 11
D) 7
E) 13

```json
{
  "problem_id": "17",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["shingled-disk","forensics"],
  "choices": ["21","17","11","7","13"],
  "answer": "E"
}
```

---

## Question 18 [1 point]

Question 18: Same question, but assume a SSTF scheduling 
policy, and a VERY FAST seek. What is the last block read?
A) 21
B) 17
C) 11
D) 7
E) 13

```json
{
  "problem_id": "18",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["shingled-disk","forensics"],
  "choices": ["21","17","11","7","13"],
  "answer": "A"
}
```

---

## Question 19 [1 point]

Question 19: Same question, but assume SATF scheduling policy, and a VERY FAST seek. What is the last 
block read?
A) 21
B) 17
C) 11
D) 7
E) 13

```json
{
  "problem_id": "19",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["shingled-disk","forensics"],
  "choices": ["21","17","11","7","13"],
  "answer": "B"
}
```

---

## Question 20 [1 point]

In a shingled disk, all writes are log-structured. Specifically, writes are directed to the currently-
being-written shingle, and the STL is updated accordingly. As a result, does disk scheduling of write requests 
(assuming a workload only contains write requests) help performance?
A) Yes (always)
B) Yes (sometimes)
C) No (never)
D) Can’t answer without more details
E) None of the above

```json
{
  "problem_id": "20",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["shingled-disk","forensics"],
  "choices": ["Yes (always)","Yes (sometimes)","No (never)","Can’t answer without more details","None of the above"],
  "answer": "B"
}
```

---

## Question 21 [1 point]

Question 21: A file descriptor is:
A) a system-wide object used to access files
B) a per-process integer used to access files
C) readily forged
D) returned to a process via the close() system call
E) hard to understand

```json
{
  "problem_id": "21",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["file-system","api","forensics"],
  "choices": ["a system-wide object used to access files","a per-process integer used to access files","readily forged","returned to a process via the close() system call","hard to understand"],
  "answer": "B"
}
```

---

## Question 22 [1 point]

Question 22: Adding the O_TRUNC flag to the open() call will
A) puts the data in a locked “trunk” file
B) causes the open call to fail (usually)
C) implies you must add O_TRUNC to close() as well
D) creates the file (if it doesn’t exist)
E) truncates the file to size=0

```json
{
  "problem_id": "22",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["file-system","api","forensics"],
  "choices": ["puts the data in a locked “trunk” file","causes the open call to fail (usually)","implies you must add O_TRUNC to close() as well","creates the file (if it doesn’t exist)","truncates the file to size=0"],
  "answer": "E"
}
```

---

## Question 23 [1 point]

Question 23: The “unlink()” system call is to the program “rm” as THIS is to the “rmdir” program
A) unlink()
B) delete()
C) rmdir()
D) link()
E) fork()

```json
{
  "problem_id": "23",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["file-system","api","forensics"],
  "choices": ["unlink()","delete()","rmdir()","link()","fork()"],
  "answer": "C"
}
```

---

## Question 24 [1 point]

Question 24: The “lseek()” call is used to
A) reposition the disk head
B) do a long disk seek, immediately
C) change the current file offset
D) force changes to disk
E) close files after a layoff period

```json
{
  "problem_id": "24",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["file-system","api","forensics"],
  "choices": ["reposition the disk head","do a long disk seek, immediately","change the current file offset","force changes to disk","close files after a layoff period"],
  "answer": "C"
}
```

---

## Question 25 [1 point]

Question 25: The following information is NOT available within a typical inode: 
A) owner
B) size (bytes)
C) blocks allocated
D) file name
E) last access time

```json
{
  "problem_id": "25",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["inode","filesystem","forensics"],
  "choices": ["owner","size (bytes)","blocks allocated","file name","last access time"],
  "answer": "D"
}
```

---

## Question 26 [1 point]

Question 26: The “read()” call is to the “cat” program as the BLANK call is to the “ls” program:
A) read()
B) readdir()
C) stat()
D) fstat()
E) umount()

```json
{
  "problem_id": "26",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["file-system","api","forensics"],
  "choices": ["read()","readdir()","stat()","fstat()","umount()"],
  "answer": "B"
}
```

---

## Question 27 [1 point]

Question 27: Which type of links do most UNIX file systems support?
A) hyperlinks
B) soft links
C) forked links
D) sausage links
E) unlinks

```json
{
  "problem_id": "27",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["filesystem","forensics"],
  "choices": ["hyperlinks","soft links","forked links","sausage links","unlinks"],
  "answer": "B"
}
```

---

## Question 28 [1 point]

Question 28: A file is NOT
A) a container for data
B) a byte array that can be read or written
C) something with a low-level name
D) easily deleted
E) something that can be referred to via a high-level name, thanks to directories

```json
{
  "problem_id": "28",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["filesystem","forensics"],
  "choices": ["a container for data","a byte array that can be read or written","something with a low-level name","easily deleted","something that can be referred to via a high-level name, thanks to directories"],
  "answer": "D"
}
```

---

## Question 29 [1 point]

Question 29: Let’s say we wish to write data to a file and then force the contents of a file to disk. We should 
thus call:
A) write()
B) write() then fsync()
C) write() then fopen()
D) write() then falloc()
E) write() then fit()

```json
{
  "problem_id": "29",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["filesystem","forensics"],
  "choices": ["write()","write() then fsync()","write() then fopen()","write() then falloc()","write() then fit()"],
  "answer": "B"
}
```

---

## Question 30 [1 point]

Question 30: To atomically replace the contents of a file foo, we should use the following sequence of 
system calls: open() [to open a new temporary file], write() to write data to the disk, force the contents to disk 
(with a certain file system call, as in question 29), and finally:
A) close() to close the file
B) rename() to change the name of the temporary file to the desired file name
C) link() to link the file to another name
D) unlink() to remove the original file foo
E) None of the above

```json
{
  "problem_id": "30",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["filesystem","forensics"],
  "choices": ["close() to close the file","rename() to change the name of the temporary file to the desired file name","link() to link the file to another name","unlink() to remove the original file foo","None of the above"],
  "answer": "B"
}
```

---

## Question 31 [1 point]

File System Implementation 
Assume you call mkdir(“/n”) on the empty root file system. The inode bitmap is missing; 
what should it look like:
inode bitmap  ????????
inodes        [d a:0 r:3] [d a:1 r:2] [] [] [] [] [] [] 
data bitmap   11000000
data          [(.,0) (..,0) (n,1)] [(.,1) (..,0)] [] [] [] [] [] []

A) 10000000
B) 11000000
C) 11100000
D) 10100000
E) None of the above

```json
{
  "problem_id": "31",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["filesystem","forensics"],
  "choices": ["10000000","11000000","11100000","10100000","None of the above"],
  "answer": "A"
}
```

---

## Question 32 [1 point]

Question 32: Assume you had instead called creat(“/z”) on an empty file system. Unfortunately, in this case, 
the data block for the root directory has gone bad. What should be in there?
inode bitmap  11000000
inodes        [d a:0 r:2] [f a:- r:1] [] [] []
data bitmap   10000000
data          [CORRUPT!] [] [] [] []
A) [(.,0) (..,0)]
B) [(.,0) (..,0) (z,1)]
C) [(.,0) (..,0) (z,2)]
D) [(.,0) (..,0) (/z,1)]
E) [(.,0) (..,0) (/z,2)]

```json
{
  "problem_id": "32",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["filesystem","forensics"],
  "choices": ["[(.,0) (..,0)]","[(.,0) (..,0) (z,1)]","[(.,0) (..,0) (z,2)]","[(.,0) (..,0) (/z,1)]","[(.,0) (..,0) (/z,2)]"],
  "answer": "A"
}
```

---

## Question 33 [1 point]

Question 33: What are the contents of the missing data block (Block 1)?
A) (.,0) (..,0)
B) (.,1) (..,0)
C) (.,2) (..,0)
D) foofoofoo
E) None of the above

```json
{
  "problem_id": "33",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["filesystem","forensics","vsfs"],
  "choices": ["(.,0) (..,0)","(.,1) (..,0)","(.,2) (..,0)","foofoofoo","None of the above"],
  "answer": "B"
}
```

---

## Question 34 [1 point]

Question 34: Which two operations were run upon the empty file system to result in this state?
A) creat(“/d”); creat(“/w”);
B) creat(“/d”); link(“/d”, “/w”);
C) creat(“/w”); unlink(“/d”);
D) mkdir(“/d”); mkdir(“/w”);
E) None of the above

```json
{
  "problem_id": "34",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["filesystem","forensics","vsfs"],
  "choices": ["creat(“/d”); creat(“/w”);","creat(“/d”); link(“/d”, “/w”);","creat(“/w”); unlink(“/d”);","mkdir(“/d”); mkdir(“/w”);","None of the above"],
  "answer": "D"
}
```

---

## Question 35 [1 point]

Let’s examine one particular corrupt file system image from VSFS for the next two questions:
inode bitmap  11000000
inodes        [d a:0 r:2] [f a:1 r:2] [] [] [] []
data bitmap   ????????
data          [(.,0) (..,0) (c,1) (m,1)] [foofoofoo] [] [] [] []

Question 35: Which ONE of the following is not true about the above file system state?
A) There is a proper root directory
B) The file “/c” exists
C) The file “/m” exists
D) If you read the first block of “/c”, you get “foofoofoo”
E) If you unlink “/c”, you can no longer read “foofoofoo”

```json
{
  "problem_id": "35",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["filesystem","forensics","vsfs"],
  "choices": ["There is a proper root directory","The file “/c” exists","The file “/m” exists","If you read the first block of “/c”, you get “foofoofoo”","If you unlink “/c”, you can no longer read “foofoofoo”"],
  "answer": "E"
}
```

---

## Question 36 [1 point]

Question 36: Which ONE of the following is true about the above file system state?
A) File “/m” is a hard link to “/c”
B) File “/c” is a hard link to “/m”
C) Both “/c” and “/m” are links to the same file
D) The root directory has many data blocks in it
E) The file “/m” has many data blocks in it

```json
{
  "problem_id": "36",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["filesystem","forensics","vsfs"],
  "choices": ["File “/m” is a hard link to “/c”","File “/c” is a hard link to “/m”","Both “/c” and “/m” are links to the same file","The root directory has many data blocks in it","The file “/m” has many data blocks in it"],
  "answer": "C"
}
```

---

## Question 37 [1 point]

Question 37: In this final file system state, which regular files exist?
A) Only /d, /g, /j
B) Only /d, /g, /j, /n
C) Only /d, /g, /j, /y/n
D) Only /d, /g, /j, /y
E) None of the above

```json
{
  "problem_id": "37",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["filesystem","forensics","vsfs"],
  "choices": ["Only /d, /g, /j","Only /d, /g, /j, /n","Only /d, /g, /j, /y/n","Only /d, /g, /j, /y","None of the above"],
  "answer": "C"
}
```

---

## Question 38 [1 point]

Question 38: In the above file system format, what is the largest number of regular-file inodes that can be allocated?
A) 1
B) 6
C) 7
D) 8
E) As many as needed

```json
{
  "problem_id": "38",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["filesystem","forensics","vsfs"],
  "choices": ["1","6","7","8","As many as needed"],
  "answer": "C"
}
```

---

## Question 39 [1 point]

Question 39: Bitmaps are useful as allocation structures because of all the reasons below EXCEPT:
A) They are compact
B) They are human readable
C) They allow for quick lookup of free space
D) They allow for lookup to readily find consecutive free blocks
E) Updates to them do not add any disk traffic

```json
{
  "problem_id": "39",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["filesystem","forensics"],
  "choices": ["They are compact","They are human readable","They allow for quick lookup of free space","They allow for lookup to readily find consecutive free blocks","Updates to them do not add any disk traffic"],
  "answer": "B"
}
```

---

## Question 40 [1 point]

Question 40: VSFS has all the following features EXCEPT:
A) Regular files
B) Directories
C) Hard links
D) Simple allocation structures
E) Fast crash consistency

```json
{
  "problem_id": "40",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["filesystem","forensics"],
  "choices": ["Regular files","Directories","Hard links","Simple allocation structures","Fast crash consistency"],
  "answer": "E"
}
```

---

## Journaling (1-4) and related questions
The following questions cover various journaling scenarios across data and metadata journaling modes. They require applying standard journaling principles.

---

## Question 41 [1 point]

Question 41: Assume that a process appends a data block to an existing (small) file. How many blocks are 
written to the journal as part of this update?
A) 1
B) 2
C) 3
D) 4
E) None of the above

```json
{
  "problem_id": "41",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["journaling","filesystem","forensics"],
  "choices": ["1","2","3","4","None of the above"],
  "answer": "C"
}
```

---

## Question 42 [1 point]

Question 42: Now assume that a process reads a block from a file. Reading, in this file system, updates the 
“last accessed time” field in the inode. How many blocks are written to the journal as part of this read?
A) 1
B) 2
C) 3
D) 4
E) None of the above

```json
{
  "problem_id": "42",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["journaling","filesystem","forensics"],
  "choices": ["1","2","3","4","None of the above"],
  "answer": "A"
}
```

---

## Question 43 [1 point]

Question 43: Now a process creates a 0-byte file in the root directory (which does not have many entries in 
it, so there is room for another entry in an existing directory data block). How many blocks are written to the 
journal as part of this file creation?
A) 1
B) 2
C) 3
D) 4
E) None of the above

```json
{
  "problem_id": "43",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["journaling","filesystem","forensics"],
  "choices": ["1","2","3","4","None of the above"],
  "answer": "D"
}
```

---

## Question 44 [1 point]

Question 44: Finally, a process deletes a 1-byte file from the root directory (leaving the root directory 
empty). Assuming the root directory only uses a single data block for its data, how many blocks are written to 
the journal as part of this file creation?
A) 1
B) 2
C) 3
D) 4
E) None of the above

```json
{
  "problem_id": "44",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["journaling","filesystem","forensics"],
  "choices": ["1","2","3","4","None of the above"],
  "answer": "E"
}
```

---

## Question 45 [1 point]

Question 45: Assume that a process has appends a data block to an existing (small) file. How many blocks 
are written to the journal as part of this update?
A) 1
B) 2
C) 3
D) 4
E) None of the above

```json
{
  "problem_id": "45",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["journaling","filesystem","forensics","ordered-journaling"],
  "choices": ["1","2","3","4","None of the above"],
  "answer": "B"
}
```

---

## Question 46 [1 point]

Question 46: Now assume that a process reads a block from a file. Reading, in this file system, updates the 
“last accessed time” field in the inode. How many blocks are written to the journal as part of this read?
A) 1
B) 2
C) 3
D) 4
E) None of the above

```json
{
  "problem_id": "46",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["journaling","filesystem","forensics","ordered-journaling"],
  "choices": ["1","2","3","4","None of the above"],
  "answer": "A"
}
```

---

## Question 47 [1 point]

Question 47: Now a process creates a 0-byte file in the root directory (which does not have many entries in 
it, so there is room for another entry in an existing directory data block). How many blocks are written to the 
journal as part of this file creation?
A) 1
B) 2
C) 3
D) 4
E) None of the above

```json
{
  "problem_id": "47",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["journaling","filesystem","forensics","ordered-journaling"],
  "choices": ["1","2","3","4","None of the above"],
  "answer": "C"
}
```

---

## Question 48 [1 point]

Question 48: Finally, a process deletes a 1-byte file from the root directory (leaving the root directory 
empty). Assuming the root directory only uses a single data block for its data, how many blocks are written to 
the journal as part of this file creation?
A) 1
B) 2
C) 3
D) 4
E) None of the above

```json
{
  "problem_id": "48",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["journaling","filesystem","forensics","ordered-journaling"],
  "choices": ["1","2","3","4","None of the above"],
  "answer": "E"
}
```

---

## Question 49 [1 point]

Question 49: Which of the following statements is NOT true about journaling file systems?
A) Journaling adds a new on-disk structure to the file system
B) Journaling is the same as write-ahead logging (the terms are used interchangeably)
C) Journaling generally increases the amount of write traffic to the disk
D) Journaling always makes performance worse (than the same file system without journaling)
E) Whether in data or ordered journaling modes, file system metadata is always first written to the 
journal before being updated in place.

```json
{
  "problem_id": "49",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["journaling","filesystem","forensics"],
  "choices": ["Journaling adds a new on-disk structure to the file system","Journaling is the same as write-ahead logging (the terms are used interchangeably)","Journaling generally increases the amount of write traffic to the disk","Journaling always makes performance worse (than the same file system without journaling)","Whether in data or ordered journaling modes, file system metadata is always first written to the journal before being updated in place."],
  "answer": "D"
}
```

---

## Question 50 [1 point]

Question 50: Which of the following best represents a final, complete, and most optimized version of the 
ordered (metadata only) journaling protocol?
A) Data write, then journal metadata write, then journal commit.
B) Data write, then journal metadata write, then journal commit, then checkpoint of metadata.
C) Data write, then journal metadata write, then journal commit, then checkpoint of metadata, then (later) mark 
the transaction free in the journal superblock.
D) Data write and journal metadata write (concurrently), then journal commit, then checkpoint of metadata, 
then (later) mark the transaction free in the journal superblock.
E) None of the above

```json
{
  "problem_id": "50",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["journaling","filesystem","forensics"],
  "choices": ["Data write, then journal metadata write, then journal commit.","Data write, then journal metadata write, then journal commit, then checkpoint of metadata.","Data write, then journal metadata write, then journal commit, then checkpoint of metadata, then (later) mark the transaction free in the journal superblock.","Data write and journal metadata write (concurrently), then journal commit, then checkpoint of metadata, then (later) mark the transaction free in the journal superblock.","None of the above"],
  "answer": "C"
}
```

---

## Log-Structured File System (1)

You discover a disk filled with what seems to be a log-structured file system. In its initial state on disk, the first 
few blocks seem to be filled with an empty file system:
[0] checkpoint: 3 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
[1] [.,0] [..,0] -- -- -- -- -- -- 
[2] type:dir size:1 refs:2 ptrs: 1 -- -- -- -- -- -- -- 
[3] chunk(imap): 2 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
As you examine these first few blocks, you realize their structure. The first block (Block 0) is the “checkpoint 
region” - it points to pieces of the inode map. Block 3 holds that first chunk of the inode map; in this case, you 
figure out that only inode 0 is live, and it lives in Block 2. Block 2 holds the inode of the root directory, which 
contains 1 block, which is located in Block 1 (the first ptr in the list of addresses held in the inode). Finally, the 
contents of the root directory are in Block 1: a . and .. entry, each referring to the root inode 0. Good job!
Now, for some questions. You perform a single file system operation, with the resulting on-disk state:
[0] checkpoint: 7 -- -- -- -- -- -- 8 -- -- -- -- -- -- -- -- 
[1] [.,0] [..,0] -- -- -- -- -- -- 
[2] type:dir size:1 refs:2 ptrs: 1 -- -- -- -- -- -- -- 
[3] chunk(imap): 2 -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
[4] [.,0] [..,0] [ku3,122] -- -- -- -- -- 
[5] type:dir size:1 refs:2 ptrs: 4 -- -- -- -- -- -- -- 
[6] type:reg size:0 refs:1 ptrs: -- -- -- -- -- -- -- -- 
[7] chunk(imap): 5 -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
[8] chunk(imap): -- -- -- -- -- -- -- -- -- -- 6 -- -- -- -- 
Question 51: What file operation was performed?
A) mkdir(“ku3”);
B) creat(“ku3”);
C) rmdir(“/“);
D) link(“.”, “ku3”);
E) None of the above

```json
{
  "problem_id": "51",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["log-structured","filesystem","forensics"],
  "choices": ["mkdir(“ku3”);","creat(“ku3”);","rmdir(“/“);","link(“.”, “ku3”);","None of the above"],
  "answer": "A"
}
```

---

## Question 52 [1 point]

Question 52: In the above file system state, which of the blocks are live?
A) 0 through 8
B) 4 through 8
C) 0 through 3
D) 0 and 4 through 8
E) None

```json
{
  "problem_id": "52",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["log-structured","filesystem","forensics"],
  "choices": ["0 through 8","4 through 8","0 through 3","0 and 4 through 8","None"],
  "answer": "D"
}
```

---

## Question 53 [1 point]

Question 53: In the above file system state, which inodes are allocated?
A) 7 and 8
B) 1, 2, and 4
C) 0 and 122
D) 5 and 6
E) None of the above

```json
{
  "problem_id": "53",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["log-structured","filesystem","forensics"],
  "choices": ["7 and 8","1, 2, and 4","0 and 122","5 and 6","None of the above"],
  "answer": "C"
}
```

---

## Question 54 [1 point]

Question 54: What file operations were performed to get to this new state?
A) A file read
B) A file link
C) A file create
D) A file create and then write
E) A file unlink

```json
{
  "problem_id": "54",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["log-structured","filesystem","forensics"],
  "choices": ["A file read","A file link","A file create","A file create and then write","A file unlink"],
  "answer": "D"
}
```

---

## Question 55 [1 point]

Question 55: In the above file system state, which of the blocks are live?
A) 0 through 11
B) 4 through 11
C) 4 through 11 (except 6 and 8)
D) 4 through 11 (except 6, 8, and 10)
E) 7 through 11

```json
{
  "problem_id": "55",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["log-structured","filesystem","forensics"],
  "choices": ["0 through 11","4 through 11","4 through 11 (except 6 and 8)","4 through 11 (except 6, 8, and 10)","7 through 11"],
  "answer": "D"
}
```

---

## Question 56 [1 point]

Question 56: In the above file system state, how many versions of the root inode exist (live or dead)?
A) 0
B) 1
C) 2
D) 3
E) 4 or more

```json
{
  "problem_id": "56",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["log-structured","filesystem","forensics"],
  "choices": ["0","1","2","3","4 or more"],
  "answer": "C"
}
```

---

## Question 57 [1 point]

Question 57: In the above file system state, how many live chunks of the imap are there?
A) 0
B) 1
C) 2
D) 3
E) 4 or more

```json
{
  "problem_id": "57",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["log-structured","filesystem","forensics"],
  "choices": ["0","1","2","3","4 or more"],
  "answer": "C"
}
```

---

## Question 58 [1 point]

Question 58: The last five blocks of the log (16-20) represent the results of which operation?
A) A directory creation
B) A file creation
C) A multi-block write
D) A file link
E) None of the above

```json
{
  "problem_id": "58",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["log-structured","filesystem","forensics"],
  "choices": ["A directory creation","A file creation","A multi-block write","A file link","None of the above"],
  "answer": "C"
}
```

---

## Question 59 [1 point]

Question 59: The blocks 12-15 represent the results of which operation?
A) A directory creation
B) A file creation
C) A multi-block write
D) A file link
E) None of the above

```json
{
  "problem_id": "59",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["log-structured","filesystem","forensics"],
  "choices": ["A directory creation","A file creation","A multi-block write","A file link","None of the above"],
  "answer": "D"
}
```

---

## Question 60 [1 point]

Question 60: If you read the contents of the first block (offset=0) of file “/ym6”, you would get:
A) f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0
B) l1l1l1l1l1l1l1l1l1l1l1l1l1l1l1
C) h2h2h2h2h2h2h2h2h2h2h2h2h2h2h2h2
D) All of the above
E) None of the above

```json
{
  "problem_id": "60",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["log-structured","filesystem","forensics"],
  "choices": ["f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0","l1l1l1l1l1l1l1l1l1l1l1l1l1l1","h2h2h2h2h2h2h2h2h2h2h2h2h2h2h2h2","All of the above","None of the above"],
  "answer": "A"
}
```

---

## Question 61 [1 point]

Question 61: Assume the following page-mapped FTL: 1000:0, 1001:1, 1002:2 (X:Y means logical address X 
maps to physical page Y). What is data is returned if the user of the SSD issues a read to address=1002?
A) aaaa
B) bbbb
C) cccc
D) dddd
E) None of the above

```json
{
  "problem_id": "61",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["flash-ssds","ftl","forensics"],
  "choices": ["aaaa","bbbb","cccc","dddd","None of the above"],
  "answer": "C"
}
```

---

## Question 62 [1 point]

Question 62: Assume the following page-mapped FTL: 100:7, 101:6, 102:5, 103:4. What is data is returned if 
the user of the SSD issues a read to address=102?
A) aaaa
B) bbbb
C) cccc
D) dddd
E) None of the above

```json
{
  "problem_id": "62",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["flash-ssds","ftl","forensics"],
  "choices": ["aaaa","bbbb","cccc","dddd","None of the above"],
  "answer": "C"
}
```

---

## Question 63 [1 point]

Question 63: Assume a page-mapped FTL. The user issues a read which returns “ffff”. Which of the 
following could NOT accurately represent the contents of the entire FTL?
A) 1000:1, 1001:3, 1002:5, 1003:7 
B) 1000:1, 1001:3, 1002:5, 1003:7, 1004:0
C) 1000:1, 1001:3, 1002:5, 1003:7, 1004:0, 1005:2
D) 1000:1, 1001:3, 1002:5, 1003:7, 1004:0, 1005:2, 1006:4
E) None of the above

```json
{
  "problem_id": "63",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["flash-ssds","ftl","forensics"],
  "choices": ["1000:1, 1001:3, 1002:5, 1003:7","1000:1, 1001:3, 1002:5, 1003:7, 1004:0","1000:1, 1001:3, 1002:5, 1003:7, 1004:0, 1005:2","1000:1, 1001:3, 1002:5, 1003:7, 1004:0, 1005:2, 1006:4","None of the above"],
  "answer": "E"
}
```

---

## Question 64 [1 point]

Question 64: Assume a page-mapped FTL. The user issues a read which returns “aaaa”. Which of the 
following could NOT accurately represent the contents of the entire FTL?
A) 1000:1, 1001:3, 1002:5, 1003:7 
B) 1000:1, 1001:3, 1002:5, 1003:7, 1004:0
C) 1000:1, 1001:3, 1002:5, 1003:7, 1004:0, 1005:2
D) 1000:1, 1001:3, 1002:5, 1003:7, 1004:0, 1005:2, 1006:4
E) None of the above

```json
{
  "problem_id": "64",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["flash-ssds","ftl","forensics"],
  "choices": ["1000:1, 1001:3, 1002:5, 1003:7","1000:1, 1001:3, 1002:5, 1003:7, 1004:0","1000:1, 1001:3, 1002:5, 1003:7, 1004:0, 1005:2","1000:1, 1001:3, 1002:5, 1003:7, 1004:0, 1005:2, 1006:4","None of the above"],
  "answer": "A"
}
```

---

## Question 65 [1 point]

Question 65: Assume the user then issues a write to the SSD(address=14, data=iiii). What will the 
contents of flash physical page 4 be just after this write takes place?
A) dddd
B) eeee
C) ffff
D) iiii
E) None of the above

```json
{
  "problem_id": "65",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["flash-ssds","ftl","forensics"],
  "choices": ["dddd","eeee","ffff","iiii","None of the above"],
  "answer": "D"
}
```

---

## Question 66 [1 point]

Question 66: Assuming Block 2 (pages 8...11) of the flash is used for the write above to address=14, which 
of the following could represent the contents of the FTL after the write completes?
A) 10:0, 11:1, 12:2, 13:3, 14:4, 15:5, 16:6, 17:7
B) 10:0, 11:1, 12:2, 13:3, 14:2, 15:5, 16:6, 17:7
C) 10:0, 11:1, 12:2, 13:3, 14:8, 15:5, 16:6, 17:7
D) 10:0, 11:1, 12:2, 13:3, 15:5, 16:6, 17:7
E) None of the above

```json
{
  "problem_id": "66",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["flash-ssds","ftl","forensics"],
  "choices": ["10:0, 11:1, 12:2, 13:3, 14:4, 15:5, 16:6, 17:7","10:0, 11:1, 12:2, 13:3, 14:2, 15:5, 16:6, 17:7","10:0, 11:1, 12:2, 13:3, 14:8, 15:5, 16:6, 17:7","10:0, 11:1, 12:2, 13:3, 15:5, 16:6, 17:7","None of the above"],
  "answer": "C"
}
```

---

## Question 67 [1 point]

Question 67: After the write (to address=14, data=iiii) is complete, the SSD decides to perform garbage 
collection (GC). Which of the following will NOT happen as part of the GC?
A) Block 0 is erased
B) Block 1 is erased
C) Data from pages 5, 6, 7 are copied elsewhere
D) The contents of the FTL (the mappings) will change
E) Block 2 is erased

```json
{
  "problem_id": "67",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["flash-ssds","ftl","forensics"],
  "choices": ["Block 0 is erased","Block 1 is erased","Data from pages 5, 6, 7 are copied elsewhere","The contents of the FTL (the mappings) will change","Block 2 is erased"],
  "answer": "A"
}
```

---

## Question 68 [1 point]

Question 68: Assume you have a page-mapped FTL. If each entry in the FTL takes 4 bytes (assuming it is 
an array), how large is the FTL? Assume the SSD is only 1 MB in size, and uses 1 KB pages.
A) 1 KB
B) 4 KB
C) 1 MB
D) 4 MB
E) None of the above

```json
{
  "problem_id": "68",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["flash-ssds","ftl","forensics"],
  "choices": ["1 KB","4 KB","1 MB","4 MB","None of the above"],
  "answer": "B"
}
```

---

## Question 69 [1 point]

Question 69: Assume the same system as in Question 68, but now with block mappings (not page). Assume 
each block fits 4 pages. Assuming each entry is still 4 bytes, how large is this block-mapped FTL?
A) 1 KB
B) 4 KB
C) 1 MB
D) 4 MB
E) None of the above

```json
{
  "problem_id": "69",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["flash-ssds","ftl","forensics"],
  "choices": ["1 KB","4 KB","1 MB","4 MB","None of the above"],
  "answer": "A"
}
```

---

## Question 70 [1 point]

Question 70: Which of the following is NOT true about flash-based SSDs?
A) SSDs need less memory to perform logical to physical translation than hard drives
B) SSDs are generally faster than hard drives for write-oriented workloads
C) SSDs are generally more expensive than hard drives (cost per byte)
D) SSDs are generally faster than hard drives for read-oriented workloads
E) SSDs use fewer moving parts than hard drives

```json
{
  "problem_id": "70",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["flash-ssds","forensics"],
  "choices": ["SSDs need less memory to perform logical to physical translation than hard drives","SSDs are generally faster than hard drives for write-oriented workloads","SSDs are generally more expensive than hard drives (cost per byte)","SSDs are generally faster than hard drives for read-oriented workloads","SSDs use fewer moving parts than hard drives"],
  "answer": "C"
}
```

---

## Question 71 [1 point]

Question 71: A trace you have accesses virtual address 0x7, which translates to 0x33. What two hex digits 
are missing from page table entry 1 above?
A) 0x0a
B) 0x0b
C) 0x0c
D) 0x0d
E) None of the above

```json
{
  "problem_id": "71",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["virtual-memory","forensics"],
  "choices": ["0x0a","0x0b","0x0c","0x0d","None of the above"],
  "answer": "C"
}
```

---

## Question 72 [1 point]

Question 72: Given the virtual address 4, which decimal physical address does it translate to?
A) 5
B) 10
C) 20
D) 54
E) 45

```json
{
  "problem_id": "72",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["virtual-memory","forensics"],
  "choices": ["5","10","20","54","45"],
  "answer": "C"
}
```

---

## Question 73 [1 point]

Question 73: Which ranges of virtual address are valid?
A) 0 ... 64
B) 0 ... 16
C) 4 ... 7 and 12 ... 15
D) 0 ... 3 and 8 ... 11
E) 80 ... 89

```json
{
  "problem_id": "73",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["virtual-memory","forensics"],
  "choices": ["0 ... 64","0 ... 16","4 ... 7 and 12 ... 15","0 ... 3 and 8 ... 11","80 ... 89"],
  "answer": "C"
}
```

---

## Question 74 [1 point]

Question 74: You are told a given system has a 30-bit virtual address, with a 4KB page size. Assuming a 
4-byte page table entry size, how big is a linear page table for a given process?
A) 1 MB
B) 2 MB
C) 4 MB
D) 8 MB
E) None of the above

```json
{
  "problem_id": "74",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["virtual-memory","forensics"],
  "choices": ["1 MB","2 MB","4 MB","8 MB","None of the above"],
  "answer": "C"
}
```

---

## Question 75 [1 point]

Question 75: You are next given system has a 10-bit virtual address. with a 256 byte page size. Assuming 
a 4-byte page table entry size, how big is a linear page table for a given process?
A) 16 bytes
B) 16 KB
C) 16 MB
D) 16 GB
E) None of the above

```json
{
  "problem_id": "75",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["virtual-memory","forensics"],
  "choices": ["16 bytes","16 KB","16 MB","16 GB","None of the above"],
  "answer": "B"
}
```

---

## Question 76 [1 point]

Question 76: You are now given some new information about a particular system. Specifically, this system 
has 1 MB linear page table size (per process), and has a 1KB page size. Assuming page table entry size is 
4 bytes, how many bits are in the virtual page number (VPN) on this system?
A) 28
B) 18
C) 8
D) 32
E) None of the above

```json
{
  "problem_id": "76",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["virtual-memory","forensics"],
  "choices": ["28","18","8","32","None of the above"],
  "answer": "B"
}
```

---

## Question 77 [1 point]

Question 77: In the above memory dump, you are told the system has 3 pages, that pages 3, 4, and 5 are in memory. 
You also check a history log and find that the last 10 pages accessed were 8, 7, 4, 2, 5, 4, 7, 3, 4, 5 (in that order, with 5 being 
most recently accessed). 
Question 77: You are then asked to determine which replacement policy was used. Is it:
A) FIFO
B) LRU
C) MRU
D) LFU
E) Cannot tell from the given information

```json
{
  "problem_id": "77",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["virtual-memory","forensics"],
  "choices": ["FIFO","LRU","MRU","LFU","Cannot tell from the given information"],
  "answer": "E"
}
```

---

## Question 78 [1 point]

Question 78: Assuming the replacement policy was FIFO, how many misses were encountered while those 
last 10 pages were accessed? (assume the memory was empty to begin)
A) 7
B) 8
C) 9
D) 10
E) None of the above

```json
{
  "problem_id": "78",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["virtual-memory","forensics"],
  "choices": ["7","8","9","10","None of the above"],
  "answer": "C"
}
```

---

## Question 79 [1 point]

Question 79: Assuming the replacement policy was LRU, how many misses were encountered while those 
last 10 pages were accessed? (assume the memory was empty to begin)
A) 7
B) 8
C) 9
D) 10
E) None of the above

```json
{
  "problem_id": "79",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["virtual-memory","forensics"],
  "choices": ["7","8","9","10","None of the above"],
  "answer": "C"
}
```

---

## Question 80 [1 point]

Question 80: Assuming the replacement policy was OPT (the optimal replacement policy), how many misses 
were encountered while those last 10 pages were accessed? (assume the memory is empty to begin)
A) 7
B) 8
C) 9
D) 10
E) None of the above

```json
{
  "problem_id": "80",
  "points": 1,
  "type": "ExactMatch",
  "tags": ["virtual-memory","forensics","optimization"],
  "choices": ["7","8","9","10","None of the above"],
  "answer": "E"
}
```

---