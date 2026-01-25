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

# Copy starter files to the project directory
echo "Setting up starter files"
cd /workspace/ostep-projects/filesystems-checker

# Copy include directory
if [ -d /workspace/include ]; then
    cp -r /workspace/include .
fi

# Copy Makefile
cp /workspace/Makefile . 2>/dev/null || true

# Clone xv6 to get mkfs tool for creating test images
echo "Setting up xv6 tools"
cd /workspace
git clone --depth 1 https://github.com/mit-pdos/xv6-public xv6 > /dev/null 2>&1 || true

# Build mkfs tool
if [ -d xv6 ]; then
    cd xv6
    # Build mkfs
    gcc -Werror -Wall -o mkfs mkfs.c 2>/dev/null || true

    # Create a simple test filesystem image
    if [ -f mkfs ]; then
        echo "Creating test filesystem image"
        # Create empty files to put in the image
        echo "test content" > /tmp/testfile
        ./mkfs /workspace/ostep-projects/filesystems-checker/fs.img /tmp/testfile 2>/dev/null || true
    fi
fi

echo "Setup complete"
exit 0
