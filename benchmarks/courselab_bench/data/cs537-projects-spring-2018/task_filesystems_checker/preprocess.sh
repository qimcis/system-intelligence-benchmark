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
DIRENT_FMT = "<H14s"
NDIRECT = 12
BPB = BSIZE * 8

base = "/workspace/xv6-public/fs_base.img"
images_dir = "/workspace/ostep-projects/filesystems-checker/tests/images"

names = [
    "valid",
    "bad_inode",
    "bad_direct",
    "bad_indirect",
    "bad_root",
    "bad_dirformat",
    "bad_bitmap",
    "bad_bitmap_marked",
    "bad_direct_twice",
    "bad_inode_referred",
]

paths = {name: os.path.join(images_dir, f"{name}.img") for name in names}

for path in paths.values():
    shutil.copy(base, path)

def read_superblock(path):
    with open(path, "rb") as f:
        f.seek(BSIZE)
        data = f.read(struct.calcsize(SUPER_FMT))
        return struct.unpack(SUPER_FMT, data)

sb_size, sb_nblocks, sb_ninodes, sb_nlog, sb_logstart, sb_inodestart, sb_bmapstart = read_superblock(base)
nbitmap = (sb_size + BPB - 1) // BPB
data_start = sb_bmapstart + nbitmap

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

def set_bitmap_bit(path, blockno, used):
    bitmap_block = sb_bmapstart + (blockno // BPB)
    bit_index = blockno % BPB
    byte_index = bit_index // 8
    bit_offset = bit_index % 8
    byte_offset = bitmap_block * BSIZE + byte_index

    with open(path, "r+b") as f:
        f.seek(byte_offset)
        b = f.read(1)
        if not b:
            return
        val = b[0]
        if used:
            val |= (1 << bit_offset)
        else:
            val &= ~(1 << bit_offset)
        f.seek(byte_offset)
        f.write(bytes([val]))

def find_free_block(path):
    with open(path, "rb") as f:
        for bmap_index in range(nbitmap):
            f.seek((sb_bmapstart + bmap_index) * BSIZE)
            bitmap = f.read(BSIZE)
            for bit in range(BPB):
                blockno = bmap_index * BPB + bit
                if blockno < data_start or blockno >= sb_size:
                    continue
                byte_index = bit // 8
                bit_offset = bit % 8
                if (bitmap[byte_index] & (1 << bit_offset)) == 0:
                    return blockno
    return None

def dir_entries(path, blockno):
    entries = []
    with open(path, "rb") as f:
        f.seek(blockno * BSIZE)
        data = f.read(BSIZE)
    entry_size = struct.calcsize(DIRENT_FMT)
    for off in range(0, BSIZE, entry_size):
        inum, name = struct.unpack(DIRENT_FMT, data[off:off + entry_size])
        clean = name.split(b"\x00", 1)[0].decode("ascii", errors="ignore")
        entries.append((off, inum, clean))
    return entries

def write_dir_inum(path, blockno, entry_offset, new_inum):
    with open(path, "r+b") as f:
        f.seek(blockno * BSIZE + entry_offset)
        f.write(struct.pack("<H", new_inum))

# Bad inode type (inum 2 should exist if dummy file is present)
off, fields = read_inode(paths["bad_inode"], 2)
fields[0] = 7
write_inode(paths["bad_inode"], off, fields)

# Bad direct address in inode
off, fields = read_inode(paths["bad_direct"], 2)
fields[5] = sb_size + 5
write_inode(paths["bad_direct"], off, fields)

# Bad indirect address in inode
off, fields = read_inode(paths["bad_indirect"], 2)
fields[4] = (NDIRECT + 1) * BSIZE
fields[5 + NDIRECT] = sb_size + 11
write_inode(paths["bad_indirect"], off, fields)

# Root directory not a directory
root_off, root_fields = read_inode(paths["bad_root"], 1)
root_fields[0] = 2
write_inode(paths["bad_root"], root_off, root_fields)

# Directory not properly formatted (bad . entry)
root_off, root_fields = read_inode(paths["bad_dirformat"], 1)
root_block = root_fields[5]
for off, inum, name in dir_entries(paths["bad_dirformat"], root_block):
    if name == ".":
        write_dir_inum(paths["bad_dirformat"], root_block, off, 2)
        break

# Address used by inode but marked free in bitmap
_, fields = read_inode(paths["bad_bitmap"], 2)
blockno = fields[5]
set_bitmap_bit(paths["bad_bitmap"], blockno, False)

# Bitmap marks block in use but it is not in use
free_block = find_free_block(paths["bad_bitmap_marked"])
if free_block is not None:
    set_bitmap_bit(paths["bad_bitmap_marked"], free_block, True)

# Direct address used more than once (duplicate root dir block)
root_off, root_fields = read_inode(paths["bad_direct_twice"], 1)
root_block = root_fields[5]
off, fields = read_inode(paths["bad_direct_twice"], 2)
fields[5] = root_block
write_inode(paths["bad_direct_twice"], off, fields)

# Inode referred to in directory but marked free
root_off, root_fields = read_inode(paths["bad_inode_referred"], 1)
root_block = root_fields[5]
target_offset = None
for off, inum, name in dir_entries(paths["bad_inode_referred"], root_block):
    if name and name not in (".", ".."):
        target_offset = off
        break
if target_offset is not None:
    write_dir_inum(paths["bad_inode_referred"], root_block, target_offset, 3)
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
