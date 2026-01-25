#!/bin/bash
set -e

echo "=== Evaluation ==="

cd /workspace/ostep-projects/concurrency-webserver/src

echo "Building webserver"
# Add pthread flag to CFLAGS for threading support
export CFLAGS="-Wall -pthread"

# Clean and build
make clean 2>/dev/null || true
if ! timeout 300 make 2>&1; then
    echo "FAIL: Build failed"
    exit 1
fi

echo "Build successful"

# Check that wserver binary exists
if [ ! -f wserver ]; then
    echo "FAIL: wserver binary not created"
    exit 1
fi

echo "PASS: wserver built successfully"
exit 0
