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

echo "PASS: xfsck built successfully"
exit 0
