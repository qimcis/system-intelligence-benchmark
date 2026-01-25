#!/bin/bash
set -e

echo "=== Evaluation ==="

cd /workspace/ostep-projects/concurrency-mapreduce

# Copy starter files from /workspace if they exist
echo "Checking for starter files..."
cp /workspace/*.h . 2>/dev/null || true
cp /workspace/*.c . 2>/dev/null || true
cp /workspace/Makefile . 2>/dev/null || true

# Look for mapreduce.c in multiple locations
echo "Looking for mapreduce.c..."
if [ ! -f mapreduce.c ]; then
    if [ -f /workspace/mapreduce.c ]; then
        echo "Found mapreduce.c in /workspace, copying..."
        cp /workspace/mapreduce.c .
    fi
fi

# List what we have
echo "Files in project directory:"
ls -la

echo "Building mapreduce library"
# Add pthread flag for threading support
export CFLAGS="-Wall -pthread -O2"
export LDFLAGS="-pthread"

# Check that mapreduce.c exists
if [ ! -f mapreduce.c ]; then
    echo "FAIL: mapreduce.c not found"
    exit 1
fi

# Clean and build
make clean 2>/dev/null || true
if ! timeout 300 make 2>&1; then
    echo "FAIL: Build failed"
    exit 1
fi

echo "Build successful"

# Check that library or binaries were created
if [ ! -f libmapreduce.so ] && [ ! -f mapreduce.o ] && [ ! -f wordcount ]; then
    echo "FAIL: No mapreduce library or binary created"
    exit 1
fi

echo "PASS: build completed successfully"
exit 0
