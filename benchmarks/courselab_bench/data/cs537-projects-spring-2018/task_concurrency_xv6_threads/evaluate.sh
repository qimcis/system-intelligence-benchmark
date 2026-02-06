#!/bin/bash
set -euo pipefail

echo "=== Evaluation ==="

cd /workspace/ostep-projects/concurrency-xv6-threads

echo "Verifying protected files were not modified"
if [ -f /tmp/checksums/protected.sha256 ]; then
  sha256sum -c /tmp/checksums/protected.sha256 || {
    echo "FAIL: Protected files were modified"
    exit 1
  }
fi
echo "All protected files unchanged"

echo "Running xv6 tests"
if ! timeout 1200 ../tester/run-tests.sh; then
  echo "FAIL: xv6 tests failed"
  exit 1
fi

echo "PASS: All tests passed"
exit 0
