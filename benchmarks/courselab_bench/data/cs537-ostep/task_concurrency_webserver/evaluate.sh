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

echo "Testing server startup and basic functionality"

# Create a test file to serve
mkdir -p /tmp/webtest
echo "Hello, World!" > /tmp/webtest/test.txt

# Start the server in background on a random port
PORT=$((8000 + RANDOM % 1000))
./wserver -p $PORT -d /tmp/webtest &
SERVER_PID=$!

# Give server time to start
sleep 2

# Check if server is still running
if ! kill -0 $SERVER_PID 2>/dev/null; then
    echo "FAIL: Server crashed immediately after starting"
    exit 1
fi

# Test basic HTTP request
set +e
RESPONSE=$(curl -s -m 5 http://localhost:$PORT/test.txt 2>/dev/null)
CURL_EXIT=$?
set -e

# Clean up server
kill $SERVER_PID 2>/dev/null || true
wait $SERVER_PID 2>/dev/null || true

if [ $CURL_EXIT -ne 0 ]; then
    echo "FAIL: Server did not respond to HTTP request"
    exit 1
fi

if [[ "$RESPONSE" == *"Hello, World!"* ]]; then
    echo "PASS: Server responded correctly to HTTP request"
    exit 0
else
    echo "FAIL: Server response incorrect"
    echo "Expected: Hello, World!"
    echo "Got: $RESPONSE"
    exit 1
fi
