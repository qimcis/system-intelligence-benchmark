#!/bin/bash
# Batch script to add all OSTEP labs to courselab_bench
#
# Usage: ./add_all_ostep_labs.sh [--dry-run]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OSTEP_REPO="https://github.com/remzi-arpacidusseau/ostep-projects"
LOCAL_REPO="/home/qi/ostep-projects"
COURSE_ID="cs537-ostep"

DRY_RUN=""
if [ "$1" == "--dry-run" ]; then
    DRY_RUN="--dry-run"
    echo "=== DRY RUN MODE ==="
fi

# C/Linux Labs
LINUX_LABS=(
    "initial-utilities/wcat"
    "initial-utilities/wgrep"
    "initial-utilities/wzip"
    "initial-utilities/wunzip"
    "initial-reverse"
    "processes-shell"
    "concurrency-webserver"
    "concurrency-pzip"
    "concurrency-mapreduce"
    "filesystems-checker"
)

# xv6 Labs (may need special handling)
XV6_LABS=(
    "initial-xv6"
    "scheduling-xv6-lottery"
    "vm-xv6-intro"
    "concurrency-xv6-threads"
)

echo "=== Adding C/Linux OSTEP Labs ==="
for lab in "${LINUX_LABS[@]}"; do
    echo ""
    echo ">>> Processing: $lab"
    python3 "$SCRIPT_DIR/add_ostep_lab.py" \
        --github-url "$OSTEP_REPO" \
        --lab-path "$lab" \
        --local-repo "$LOCAL_REPO" \
        --course-id "$COURSE_ID" \
        $DRY_RUN || {
            echo "WARNING: Failed to add $lab, continuing..."
        }
done

echo ""
echo "=== xv6 Labs (require special setup) ==="
echo "The following xv6 labs require QEMU and xv6 setup:"
for lab in "${XV6_LABS[@]}"; do
    echo "  - $lab"
done
echo ""
echo "To add xv6 labs, you'll need to:"
echo "  1. Update the Docker image in compose.yaml to include QEMU"
echo "  2. Modify preprocess.sh to clone and build xv6"
echo "  3. Update evaluate.sh to use the xv6 testing framework"

echo ""
echo "=== Summary ==="
if [ -z "$DRY_RUN" ]; then
    echo "Labs added successfully. Review with:"
    echo "  ls -la $SCRIPT_DIR/data/$COURSE_ID/"
else
    echo "Dry run complete. Run without --dry-run to create files."
fi
