#!/bin/bash
set -e

echo "=== Setting up CS537 Project 5: File System Checker ==="

cd /workspace

echo "Installing dependencies"
apt-get update > /dev/null 2>&1
apt-get install -y git python3 > /dev/null 2>&1

echo "Cloning ostep-projects repository"
git clone https://github.com/remzi-arpacidusseau/ostep-projects.git > /dev/null 2>&1
cd ostep-projects
git checkout 76cff3f89f4bf337af6e02e53a831b7eeb1396df > /dev/null 2>&1
rm -rf .git

cd /workspace

echo "Cloning xv6-public source"
git clone https://github.com/mit-pdos/xv6-public.git > /dev/null 2>&1
cd xv6-public
git checkout eeb7b415dbcb12cc362d0783e41c3d1f44066b17 > /dev/null 2>&1
rm -rf .git

cp fs.h param.h stat.h types.h /workspace/ostep-projects/filesystems-checker/

echo "Building mkfs"
gcc -Wall -Werror -Wno-error=stringop-truncation -O2 -o mkfs mkfs.c

echo "Generating file system images"
echo "dummy" > dummy.txt
./mkfs fs_base.img dummy.txt > /dev/null 2>&1

mkdir -p /workspace/ostep-projects/filesystems-checker/tests/images

python3 - <<'PY'
import os
import shutil
import struct

BSIZE = 512
DINODE_SIZE = 64
IPB = BSIZE // DINODE_SIZE
SUPER_FMT = "<7I"
DINODE_FMT = "<hhhhI13I"

base = "/workspace/xv6-public/fs_base.img"
images_dir = "/workspace/ostep-projects/filesystems-checker/tests/images"

valid = os.path.join(images_dir, "valid.img")
bad_inode = os.path.join(images_dir, "bad_inode.img")
bad_direct = os.path.join(images_dir, "bad_direct.img")
bad_root = os.path.join(images_dir, "bad_root.img")
bad_bitmap = os.path.join(images_dir, "bad_bitmap.img")

shutil.copy(base, valid)
shutil.copy(base, bad_inode)
shutil.copy(base, bad_direct)
shutil.copy(base, bad_root)
shutil.copy(base, bad_bitmap)

def read_superblock(path):
    with open(path, "rb") as f:
        f.seek(BSIZE)
        data = f.read(struct.calcsize(SUPER_FMT))
        return struct.unpack(SUPER_FMT, data)

sb_size, sb_nblocks, sb_ninodes, sb_nlog, sb_logstart, sb_inodestart, sb_bmapstart = read_superblock(base)

def inode_offset(inum):
    block = sb_inodestart + (inum // IPB)
    return block * BSIZE + (inum % IPB) * DINODE_SIZE

def read_inode(path, inum):
    with open(path, "rb") as f:
        off = inode_offset(inum)
        f.seek(off)
        data = f.read(DINODE_SIZE)
        fields = list(struct.unpack(DINODE_FMT, data))
    return off, fields

def write_inode(path, off, fields):
    with open(path, "r+b") as f:
        f.seek(off)
        f.write(struct.pack(DINODE_FMT, *fields))

# Bad inode type (inum 2 should exist if dummy file is present)
off, fields = read_inode(bad_inode, 2)
fields[0] = 7
write_inode(bad_inode, off, fields)

# Bad direct address in inode
off, fields = read_inode(bad_direct, 2)
fields[5] = sb_size + 5
write_inode(bad_direct, off, fields)

# Root directory not a directory
root_off, root_fields = read_inode(bad_root, 1)
root_fields[0] = 2
write_inode(bad_root, root_off, root_fields)

# Address used by inode but marked free in bitmap
_, fields = read_inode(bad_bitmap, 2)
blockno = fields[5]

BPB = BSIZE * 8
bitmap_block = sb_bmapstart + (blockno // BPB)
bit_index = blockno % BPB
byte_index = bit_index // 8
bit_offset = bit_index % 8
byte_offset = bitmap_block * BSIZE + byte_index

with open(bad_bitmap, "r+b") as f:
    f.seek(byte_offset)
    b = f.read(1)
    if b:
        val = b[0]
        val &= ~(1 << bit_offset)
        f.seek(byte_offset)
        f.write(bytes([val]))
PY

echo "Creating checksums for protected files"
mkdir -p /tmp/checksums
CHECKSUM_FILE=/tmp/checksums/protected.sha256
: > "$CHECKSUM_FILE"

for img in /workspace/ostep-projects/filesystems-checker/tests/images/*.img; do
  sha256sum "$img" >> "$CHECKSUM_FILE"
  echo "  Protected: $img"
done

echo "Setup complete"
exit 0
