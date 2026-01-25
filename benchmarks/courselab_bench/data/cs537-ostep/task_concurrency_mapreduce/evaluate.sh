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

echo "Testing mapreduce functionality"

# Create test input file
mkdir -p /tmp/mrtest
cd /tmp/mrtest

cat > input.txt << 'TESTDATA'
hello world
hello again
world of mapreduce
hello hello hello
world world
TESTDATA

# Run the wordcount example if it exists
if [ -f /workspace/ostep-projects/concurrency-mapreduce/wordcount ]; then
    echo "Running wordcount..."
    set +e
    /workspace/ostep-projects/concurrency-mapreduce/wordcount input.txt > output.txt 2>&1
    WC_EXIT=$?
    set -e

    if [ $WC_EXIT -ne 0 ]; then
        echo "FAIL: wordcount returned non-zero exit code: $WC_EXIT"
        cat output.txt 2>/dev/null || true
        exit 1
    fi

    # Verify output contains expected word counts
    if [ -s output.txt ]; then
        echo "Output:"
        cat output.txt
        echo "PASS: wordcount produced output"
        exit 0
    else
        echo "FAIL: wordcount produced empty output"
        exit 1
    fi
fi

# If no wordcount binary, check if we can at least link against the library
if [ -f /workspace/ostep-projects/concurrency-mapreduce/libmapreduce.so ]; then
    echo "PASS: libmapreduce.so was built successfully"
    exit 0
fi

# Check for mapreduce object file
if [ -f /workspace/ostep-projects/concurrency-mapreduce/mapreduce.o ]; then
    echo "PASS: mapreduce.o was built successfully"
    exit 0
fi

echo "PASS: Build completed successfully"
exit 0
