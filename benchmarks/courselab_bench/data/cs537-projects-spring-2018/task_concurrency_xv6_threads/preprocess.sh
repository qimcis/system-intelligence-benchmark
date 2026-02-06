#!/bin/bash
set -e

echo "=== Setting up CS537 Project 4b: xv6 Threads ==="

cd /workspace/ostep-projects/concurrency-xv6-threads

# Ensure no reference-solution directories are present in the sandbox.
rm -rf xv6-src-clean xv6-src-mod src/xv6-src-clean src/xv6-src-mod

mkdir -p tests

cat > tests/test_clone.c <<'EOT'
#include "types.h"
#include "stat.h"
#include "param.h"
#include "user.h"

volatile int shared = 0;

void
worker(void *arg1, void *arg2)
{
    int *ptr = (int *)arg1;
    (void)arg2;
    *ptr = 42;
    exit();
}

int
main(int argc, char *argv[])
{
    (void)argc;
    (void)argv;

    void *stack = malloc(PGSIZE * 2);
    if (stack == 0) {
        printf(1, "XV6_TEST_OUTPUT clone_join_fail\n");
        exit();
    }

    uint sp = ((uint)stack + PGSIZE - 1) & ~(PGSIZE - 1);

    int pid = clone(worker, (void *)&shared, 0, (void *)sp);
    if (pid < 0) {
        printf(1, "XV6_TEST_OUTPUT clone_join_fail\n");
        exit();
    }

    void *stack_out = 0;
    int joined = join(&stack_out);
    if (joined < 0) {
        printf(1, "XV6_TEST_OUTPUT clone_join_fail\n");
        exit();
    }

    if (shared != 42) {
        printf(1, "XV6_TEST_OUTPUT clone_join_fail\n");
        exit();
    }

    if (stack_out != (void *)sp) {
        printf(1, "XV6_TEST_OUTPUT clone_join_fail\n");
        exit();
    }

    printf(1, "XV6_TEST_OUTPUT clone_join_pass\n");
    exit();
}
EOT

cat > tests/test_thread.c <<'EOT'
#include "types.h"
#include "stat.h"
#include "user.h"

#define NTHREADS 4
#define NITERS 1000

volatile int counter = 0;
lock_t lock;

void
worker(void *arg1, void *arg2)
{
    int i;
    (void)arg1;
    (void)arg2;

    for (i = 0; i < NITERS; i++) {
        lock_acquire(&lock);
        counter++;
        lock_release(&lock);
    }

    exit();
}

int
main(int argc, char *argv[])
{
    int i;
    (void)argc;
    (void)argv;

    lock_init(&lock);

    for (i = 0; i < NTHREADS; i++) {
        int pid = thread_create(worker, 0, 0);
        if (pid < 0) {
            printf(1, "XV6_TEST_OUTPUT thread_lib_fail\n");
            exit();
        }
    }

    for (i = 0; i < NTHREADS; i++) {
        int pid = thread_join();
        if (pid < 0) {
            printf(1, "XV6_TEST_OUTPUT thread_lib_fail\n");
            exit();
        }
    }

    if (counter != (NTHREADS * NITERS)) {
        printf(1, "XV6_TEST_OUTPUT thread_lib_fail\n");
        exit();
    }

    printf(1, "XV6_TEST_OUTPUT thread_lib_pass\n");
    exit();
}
EOT

cat > tests/test_join_none.c <<'EOT'
#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    (void)argc;
    (void)argv;

    void *stack = 0;
    int pid = join(&stack);
    if (pid != -1) {
        printf(1, "XV6_TEST_OUTPUT join_none_fail\n");
        exit();
    }

    printf(1, "XV6_TEST_OUTPUT join_none_pass\n");
    exit();
}
EOT

cat > tests/test_thread_args.c <<'EOT'
#include "types.h"
#include "stat.h"
#include "user.h"

#define NTHREADS 3

volatile int results[NTHREADS];

void
worker(void *arg1, void *arg2)
{
    int idx = (int)(uint)arg1;
    int val = (int)(uint)arg2;

    results[idx] = val;
    exit();
}

int
main(int argc, char *argv[])
{
    int i;
    (void)argc;
    (void)argv;

    for (i = 0; i < NTHREADS; i++) {
        results[i] = 0;
    }

    for (i = 0; i < NTHREADS; i++) {
        int pid = thread_create(worker, (void *)(uint)i, (void *)(uint)(i + 10));
        if (pid < 0) {
            printf(1, "XV6_TEST_OUTPUT thread_args_fail\n");
            exit();
        }
    }

    for (i = 0; i < NTHREADS; i++) {
        int pid = thread_join();
        if (pid < 0) {
            printf(1, "XV6_TEST_OUTPUT thread_args_fail\n");
            exit();
        }
    }

    for (i = 0; i < NTHREADS; i++) {
        if (results[i] != (i + 10)) {
            printf(1, "XV6_TEST_OUTPUT thread_args_fail\n");
            exit();
        }
    }

    printf(1, "XV6_TEST_OUTPUT thread_args_pass\n");
    exit();
}
EOT

cat > tests/test_thread_join_none.c <<'EOT'
#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    (void)argc;
    (void)argv;

    int pid = thread_join();
    if (pid != -1) {
        printf(1, "XV6_TEST_OUTPUT thread_join_none_fail\n");
        exit();
    }

    printf(1, "XV6_TEST_OUTPUT thread_join_none_pass\n");
    exit();
}
EOT

cat > tests/pre <<'EOT'
../tester/xv6-edit-makefile.sh src/Makefile test_clone,test_thread,test_join_none,test_thread_args,test_thread_join_none > src/Makefile.test
{ echo "TOOLPREFIX ="; cat src/Makefile.test; } > src/Makefile.test.tmp
mv src/Makefile.test.tmp src/Makefile.test
echo "CFLAGS += -Wno-error=array-bounds" >> src/Makefile.test
cp -f tests/test_clone.c src/test_clone.c
cp -f tests/test_thread.c src/test_thread.c
cp -f tests/test_join_none.c src/test_join_none.c
cp -f tests/test_thread_args.c src/test_thread_args.c
cp -f tests/test_thread_join_none.c src/test_thread_join_none.c
cd src
make -f Makefile.test TOOLPREFIX= clean
make -f Makefile.test TOOLPREFIX= xv6.img
make -f Makefile.test TOOLPREFIX= fs.img
cd ..
EOT

cat > tests/1.desc <<'EOT'
clone/join basic correctness
EOT

cat > tests/1.run <<'EOT'
set -euo pipefail; cd src; ../../tester/run-xv6-command.exp CPUS=1 Makefile.test test_clone | tr -d '\r' | grep XV6_TEST_OUTPUT; cd ..
EOT

cat > tests/1.out <<'EOT'
XV6_TEST_OUTPUT clone_join_pass
EOT

cat > tests/1.err <<'EOT'
EOT

cat > tests/1.rc <<'EOT'
0
EOT

cat > tests/2.desc <<'EOT'
thread library and lock correctness
EOT

cat > tests/2.run <<'EOT'
set -euo pipefail; cd src; ../../tester/run-xv6-command.exp CPUS=1 Makefile.test test_thread | tr -d '\r' | grep XV6_TEST_OUTPUT; cd ..
EOT

cat > tests/2.out <<'EOT'
XV6_TEST_OUTPUT thread_lib_pass
EOT

cat > tests/2.err <<'EOT'
EOT

cat > tests/2.rc <<'EOT'
0
EOT

cat > tests/3.desc <<'EOT'
join returns -1 when no thread children
EOT

cat > tests/3.run <<'EOT'
set -euo pipefail; cd src; ../../tester/run-xv6-command.exp CPUS=1 Makefile.test test_join_none | tr -d '\r' | grep XV6_TEST_OUTPUT; cd ..
EOT

cat > tests/3.out <<'EOT'
XV6_TEST_OUTPUT join_none_pass
EOT

cat > tests/3.err <<'EOT'
EOT

cat > tests/3.rc <<'EOT'
0
EOT

cat > tests/4.desc <<'EOT'
thread_create argument passing
EOT

cat > tests/4.run <<'EOT'
set -euo pipefail; cd src; ../../tester/run-xv6-command.exp CPUS=1 Makefile.test test_thread_args | tr -d '\r' | grep XV6_TEST_OUTPUT; cd ..
EOT

cat > tests/4.out <<'EOT'
XV6_TEST_OUTPUT thread_args_pass
EOT

cat > tests/4.err <<'EOT'
EOT

cat > tests/4.rc <<'EOT'
0
EOT

cat > tests/5.desc <<'EOT'
thread_join returns -1 when no threads exist
EOT

cat > tests/5.run <<'EOT'
set -euo pipefail; cd src; ../../tester/run-xv6-command.exp CPUS=1 Makefile.test test_thread_join_none | tr -d '\r' | grep XV6_TEST_OUTPUT; cd ..
EOT

cat > tests/5.out <<'EOT'
XV6_TEST_OUTPUT thread_join_none_pass
EOT

cat > tests/5.err <<'EOT'
EOT

cat > tests/5.rc <<'EOT'
0
EOT

echo "Creating checksums for protected files"
mkdir -p /tmp/checksums
CHECKSUM_FILE=/tmp/checksums/protected.sha256
: > "$CHECKSUM_FILE"

PROTECTED_FILES=(
  "../tester/run-tests.sh"
  "tests/pre"
  "tests/1.desc"
  "tests/1.run"
  "tests/1.out"
  "tests/1.err"
  "tests/1.rc"
  "tests/2.desc"
  "tests/2.run"
  "tests/2.out"
  "tests/2.err"
  "tests/2.rc"
  "tests/test_clone.c"
  "tests/test_thread.c"
  "tests/test_join_none.c"
  "tests/test_thread_args.c"
  "tests/test_thread_join_none.c"
  "tests/3.desc"
  "tests/3.run"
  "tests/3.out"
  "tests/3.err"
  "tests/3.rc"
  "tests/4.desc"
  "tests/4.run"
  "tests/4.out"
  "tests/4.err"
  "tests/4.rc"
  "tests/5.desc"
  "tests/5.run"
  "tests/5.out"
  "tests/5.err"
  "tests/5.rc"
)

for file in "${PROTECTED_FILES[@]}"; do
  if [ -f "$file" ]; then
    sha256sum "$file" >> "$CHECKSUM_FILE"
    echo "  Protected: $file"
  fi
done

echo "Setup complete"
exit 0
