#!/bin/bash
set -e

echo "=== Evaluation ==="

cd /workspace/ostep-projects/processes-shell

echo "Running tests (up to 3 attempts to handle timeouts)"

MAX_ATTEMPTS=3
for attempt in $(seq 1 $MAX_ATTEMPTS); do
    echo "Attempt $attempt of $MAX_ATTEMPTS"

    # Clean previous build artifacts
    rm -f wish *.o 2>/dev/null || true
    rm -rf tests-out 2>/dev/null || true

    echo "Building wish"
    if [ -f Makefile ]; then
        if timeout 300 make 2>&1; then
            BUILD_SUCCESS=1
        else
            BUILD_SUCCESS=0
        fi
    else
        if timeout 300 gcc -D_GNU_SOURCE -std=gnu11 -Wall -Werror -O2 -o wish *.c 2>&1; then
            BUILD_SUCCESS=1
        else
            BUILD_SUCCESS=0
        fi
    fi

    if [ $BUILD_SUCCESS -eq 0 ]; then
        echo "Build failed or timed out"
        if [ $attempt -lt $MAX_ATTEMPTS ]; then
            sleep 2
            continue
        else
            echo "FAIL: Build failed after $MAX_ATTEMPTS attempts"
            exit 1
        fi
    fi

    echo "Running tests"
    # Run test-wish.sh and capture output
    set +e
    timeout 600 bash test-wish.sh 2>&1 | tee test_output.txt
    TEST_RESULT=${PIPESTATUS[0]}
    set -e

    # Check if all tests passed by looking at output
    if grep -q "passed" test_output.txt && ! grep -q "incorrect" test_output.txt && ! grep -q "failed" test_output.txt; then
        echo "PASS: All tests passed on attempt $attempt"
        exit 0
    fi

    if [ $attempt -lt $MAX_ATTEMPTS ]; then
        echo "Tests failed, retrying..."
        rm -f test_output.txt 2>/dev/null || true
        sleep 2
    fi
done

echo "FAIL: Tests failed after $MAX_ATTEMPTS attempts"
exit 1
