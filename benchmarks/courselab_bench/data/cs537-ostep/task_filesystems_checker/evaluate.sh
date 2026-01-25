#!/bin/bash
set -e

echo "=== Evaluation ==="

cd /workspace/ostep-projects/filesystems-checker

# Copy starter files if they exist in /workspace
echo "Checking for starter files..."
if [ -d /workspace/include ]; then
    cp -r /workspace/include . 2>/dev/null || true
fi
cp /workspace/Makefile . 2>/dev/null || true

# Look for xfsck.c in multiple locations
echo "Looking for xfsck.c..."
if [ ! -f xfsck.c ]; then
    # Check /workspace root
    if [ -f /workspace/xfsck.c ]; then
        echo "Found xfsck.c in /workspace, copying..."
        cp /workspace/xfsck.c .
    fi
fi

# List what we have
echo "Files in project directory:"
ls -la

echo "Building xfsck (filesystem checker)"

# Check that xfsck.c exists
if [ ! -f xfsck.c ]; then
    echo "FAIL: xfsck.c not found in any location"
    exit 1
fi

# Clean and build
make clean 2>/dev/null || true
if ! timeout 300 make 2>&1; then
    # Try manual compilation if Makefile fails
    echo "Makefile failed, trying manual compilation..."
    if ! timeout 300 gcc -Wall -O2 -Iinclude -o xfsck xfsck.c 2>&1; then
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

mkdir -p /tmp/fstest
cd /tmp/fstest

# Test 1: Check behavior with missing argument
echo "Test 1: Missing argument should print usage and exit non-zero"
set +e
OUTPUT=$(/workspace/ostep-projects/filesystems-checker/xfsck 2>&1)
NO_ARG_EXIT=$?
set -e

echo "Output: $OUTPUT"
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

# Test 3: Check with valid filesystem image if available
if [ -f /workspace/ostep-projects/filesystems-checker/fs.img ]; then
    echo "Test 3: Checking valid filesystem image"
    set +e
    OUTPUT=$(/workspace/ostep-projects/filesystems-checker/xfsck /workspace/ostep-projects/filesystems-checker/fs.img 2>&1)
    VALID_EXIT=$?
    set -e

    echo "Output: $OUTPUT"
    echo "Exit code: $VALID_EXIT"

    if [ $VALID_EXIT -eq 0 ]; then
        echo "Passed: xfsck reports valid filesystem as clean"
    else
        echo "Note: xfsck found issues in test image (may be expected)"
    fi
fi

# Test 4: Check behavior with invalid (empty) file
echo "Test 4: Invalid filesystem image"
dd if=/dev/zero of=invalid.img bs=512 count=10 2>/dev/null
set +e
OUTPUT=$(/workspace/ostep-projects/filesystems-checker/xfsck invalid.img 2>&1)
INVALID_EXIT=$?
set -e

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
