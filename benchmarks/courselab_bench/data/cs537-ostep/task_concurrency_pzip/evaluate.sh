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

echo "Testing pzip functionality"

# Create test files
mkdir -p /tmp/pziptest
cd /tmp/pziptest

# Create a test file with repeated patterns (good for RLE compression)
echo "Creating test file with repeated content..."
for i in $(seq 1 1000); do
    echo "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    echo "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
done > testfile.txt

# Get the original file for comparison
ORIGINAL_CONTENT=$(cat testfile.txt)

# Run pzip on the test file
echo "Running pzip..."
set +e
/workspace/ostep-projects/concurrency-pzip/pzip testfile.txt > testfile.z 2>&1
PZIP_EXIT=$?
set -e

if [ $PZIP_EXIT -ne 0 ]; then
    echo "FAIL: pzip returned non-zero exit code: $PZIP_EXIT"
    exit 1
fi

# Check that output file was created and has content
if [ ! -s testfile.z ]; then
    echo "FAIL: pzip did not produce output"
    exit 1
fi

echo "pzip produced output file"

# Verify the compressed file can be decompressed with punzip if it exists
if [ -f /workspace/ostep-projects/concurrency-pzip/punzip ]; then
    echo "Testing with punzip..."
    /workspace/ostep-projects/concurrency-pzip/punzip testfile.z > testfile_decoded.txt
    if diff -q testfile.txt testfile_decoded.txt > /dev/null 2>&1; then
        echo "PASS: pzip/punzip roundtrip successful"
        exit 0
    else
        echo "FAIL: Decompressed content does not match original"
        exit 1
    fi
fi

# If no punzip, just verify the compressed output is in the expected RLE format
# The format is: 4-byte count (little-endian) + 1-byte character
# Check that the output is smaller than input (compression worked) or at least non-empty
ORIGINAL_SIZE=$(wc -c < testfile.txt)
COMPRESSED_SIZE=$(wc -c < testfile.z)

echo "Original size: $ORIGINAL_SIZE bytes"
echo "Compressed size: $COMPRESSED_SIZE bytes"

if [ $COMPRESSED_SIZE -gt 0 ]; then
    echo "PASS: pzip compiled and produced output"
    exit 0
else
    echo "FAIL: pzip produced empty output"
    exit 1
fi
