#!/bin/bash
set -e

echo "=== Evaluation ==="

cd /workspace/ostep-projects/concurrency-pzip

echo "Building pzip"
# Add pthread flag for threading support
export CFLAGS="-Wall -pthread -O2"

# Clean and build
make clean 2>/dev/null || true
if ! timeout 300 make 2>&1; then
    echo "FAIL: Build failed"
    exit 1
fi

echo "Build successful"

# Check that pzip binary exists
if [ ! -f pzip ]; then
    echo "FAIL: pzip binary not created"
    exit 1
fi

echo "PASS: pzip built successfully"
exit 0
