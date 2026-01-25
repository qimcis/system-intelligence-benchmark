#!/bin/bash
set -e

echo "=== Setting up OSTEP Lab: concurrency-mapreduce ==="

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

# Copy starter files to the project directory
echo "Setting up starter files"
cd /workspace/ostep-projects/concurrency-mapreduce
cp /workspace/*.h . 2>/dev/null || true
cp /workspace/*.c . 2>/dev/null || true
cp /workspace/Makefile . 2>/dev/null || true

echo "Setup complete"
exit 0
