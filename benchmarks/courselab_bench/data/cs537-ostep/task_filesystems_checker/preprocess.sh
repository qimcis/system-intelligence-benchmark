#!/bin/bash
set -e

echo "=== Setting up OSTEP Lab: filesystems-checker ==="

cd /workspace

echo "Installing git"
apt-get update > /dev/null 2>&1
apt-get install -y git > /dev/null 2>&1

echo "Cloning repository"
git clone https://github.com/remzi-arpacidusseau/ostep-projects ostep-projects > /dev/null 2>&1
cd ostep-projects
git checkout 76cff3f89f4bf337af6e02e53a831b7eeb1396df > /dev/null 2>&1

echo "Removing git history"
rm -rf .git

echo "Creating checksums for protected files"
cd filesystems-checker

mkdir -p /tmp/checksums
CHECKSUM_FILE=/tmp/checksums/protected.sha256
: > "$CHECKSUM_FILE"

if [ -d tests ]; then
  find tests -type f | sort | while IFS= read -r file; do
    sha256sum "$file" >> "$CHECKSUM_FILE"
    echo "  Protected: $file"
  done
fi

echo "Setup complete"
exit 0
