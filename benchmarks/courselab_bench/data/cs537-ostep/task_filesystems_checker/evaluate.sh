#!/bin/bash
set -e

echo "=== Evaluation ==="

cd /workspace/ostep-projects/filesystems-checker

echo "Building xfsck (filesystem checker)"

# Clean and build
make clean 2>/dev/null || true
if ! timeout 300 make 2>&1; then
    # Try manual compilation if Makefile fails
    echo "Makefile failed, trying manual compilation..."
    if ! timeout 300 gcc -D_GNU_SOURCE -std=gnu11 -Wall -O2 -o xfsck *.c 2>&1; then
        echo "FAIL: Build failed"
        exit 1
    fi
fi

echo "Build successful"

# Check that xfsck binary exists
if [ ! -f xfsck ]; then
    echo "FAIL: xfsck binary not created"
    exit 1
fi

echo "Testing xfsck functionality"

# Create a minimal valid xv6 filesystem image for testing
# xv6 uses a simple filesystem structure:
# - Block 0: unused (boot block)
# - Block 1: superblock
# - Block 2+: inode blocks, bitmap, data blocks

mkdir -p /tmp/fstest
cd /tmp/fstest

# Test 1: Check behavior with missing argument
echo "Test 1: Missing argument should print usage and exit non-zero"
set +e
/workspace/ostep-projects/filesystems-checker/xfsck 2>&1
NO_ARG_EXIT=$?
set -e

# According to spec, missing image should print "Usage: xfsck <file_system_image>" and exit
if [ $NO_ARG_EXIT -eq 0 ]; then
    echo "FAIL: xfsck should exit non-zero with no arguments"
    exit 1
fi
echo "Passed: xfsck exits non-zero with no arguments"

# Test 2: Check behavior with non-existent file
echo "Test 2: Non-existent file should print error"
set +e
OUTPUT=$(/workspace/ostep-projects/filesystems-checker/xfsck /nonexistent/file.img 2>&1)
NOFILE_EXIT=$?
set -e

if [ $NOFILE_EXIT -eq 0 ]; then
    echo "FAIL: xfsck should exit non-zero with non-existent file"
    exit 1
fi
echo "Passed: xfsck handles non-existent file correctly"

# Test 3: Check behavior with invalid (empty) file
echo "Test 3: Invalid filesystem image"
dd if=/dev/zero of=invalid.img bs=512 count=10 2>/dev/null
set +e
OUTPUT=$(/workspace/ostep-projects/filesystems-checker/xfsck invalid.img 2>&1)
INVALID_EXIT=$?
set -e

# Invalid image should produce some error output
echo "Output for invalid image: $OUTPUT"
echo "Exit code: $INVALID_EXIT"

# As long as it doesn't crash (segfault), it's acceptable
if [ $INVALID_EXIT -eq 139 ] || [ $INVALID_EXIT -eq 134 ]; then
    echo "FAIL: xfsck crashed (segfault or abort) on invalid image"
    exit 1
fi

echo "Passed: xfsck handles invalid image without crashing"

echo "PASS: xfsck built and handles edge cases correctly"
exit 0
