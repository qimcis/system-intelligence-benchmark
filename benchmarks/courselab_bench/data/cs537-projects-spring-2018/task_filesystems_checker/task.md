# CS537 Spring 2018 Project 5: File System Checking

In this lab you will implement a file system checker for the xv6 file system image format. Your program (`xcheck`) should verify consistency properties and report the first error found using the exact error messages specified in the assignment.

## What to do

1. Read the full project description in:
   `/workspace/ostep-projects/filesystems-checker/README.md`
2. Implement your checker in:
   `/workspace/ostep-projects/filesystems-checker/xcheck.c`

## Notes

- Your program must be invoked as `xcheck <file_system_image>`.
- Errors must be printed to **standard error** with exact messages and exit code 1.
- A clean image should produce no output and exit code 0.
- The evaluator runs multiple images (valid and corrupted) and checks your output.

Do not modify the provided test images or harness files.
