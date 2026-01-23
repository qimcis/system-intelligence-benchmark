#!/usr/bin/env python3
"""
OSTEP Lab Addition Tool

Automates adding OSTEP/CS537 labs to the courselab_bench benchmark.

Usage:
    python add_ostep_lab.py --github-url <URL> --lab-path <path> [options]

Example:
    python add_ostep_lab.py \
        --github-url https://github.com/remzi-arpacidusseau/ostep-projects \
        --lab-path initial-utilities/wcat \
        --course-id cs537-ostep \
        --course-name "UW-Madison CS537: Operating Systems (OSTEP)" \
        --institution "UW-Madison"
"""

import argparse
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path
from typing import Optional


def clone_repo(github_url: str, dest: Path) -> Path:
    """Clone a GitHub repository to a destination directory."""
    print(f"Cloning {github_url}...")
    subprocess.run(
        ["git", "clone", "--depth=1", github_url, str(dest)],
        check=True,
        capture_output=True,
    )
    return dest


def get_commit_hash(repo_path: Path) -> str:
    """Get the current commit hash of a repository."""
    result = subprocess.run(
        ["git", "rev-parse", "HEAD"],
        cwd=repo_path,
        capture_output=True,
        text=True,
        check=True,
    )
    return result.stdout.strip()


def detect_lab_type(lab_path: Path) -> str:
    """Detect the type of lab based on files present."""
    has_xv6_makefile = False
    if (lab_path / "Makefile").exists():
        content = (lab_path / "Makefile").read_text()
        if "xv6" in content.lower() or "qemu" in content.lower():
            has_xv6_makefile = True

    if "xv6" in lab_path.name.lower() or has_xv6_makefile:
        return "xv6"
    return "c-linux"


def extract_task_description(lab_path: Path, parent_readme: Optional[Path] = None) -> str:
    """Extract task description from README files."""
    readme_path = lab_path / "README.md"
    local_content = ""

    # Try local README first
    if readme_path.exists():
        local_content = readme_path.read_text()

    # Parent READMEs often have the actual specs (e.g., initial-utilities/README.md)
    # Extract the relevant section for this specific lab
    parent_section = ""
    if parent_readme and parent_readme.exists():
        parent_content = parent_readme.read_text()
        lab_name = lab_path.name

        # Try to extract the section for this specific lab
        # Pattern matches ## wcat or ## `wcat` etc until the next ## section
        pattern = rf"^##\s+\**`?{re.escape(lab_name)}`?\**\s*$.*?(?=^##\s|\Z)"
        match = re.search(pattern, parent_content, re.DOTALL | re.MULTILINE | re.IGNORECASE)
        if match:
            parent_section = match.group(0).strip()

    # Also check for grandparent README (e.g., ostep-projects/README.md for processes-shell)
    grandparent_readme = lab_path.parent.parent / "README.md" if lab_path.parent.parent else None
    grandparent_section = ""
    if grandparent_readme and grandparent_readme.exists() and not parent_section:
        grandparent_content = grandparent_readme.read_text()
        lab_name = lab_path.name
        pattern = rf"\[{re.escape(lab_name.replace('-', ' ').title())}\].*?(?=\n\*|\n##|\Z)"
        match = re.search(pattern, grandparent_content, re.DOTALL | re.IGNORECASE)
        if match:
            grandparent_section = match.group(0).strip()

    # Combine: parent section (detailed spec) + local content (test instructions)
    if parent_section:
        # Include intro from parent README if it's substantial
        parent_content = parent_readme.read_text() if parent_readme else ""
        intro_match = re.match(r"^(#[^#].*?)(?=^##)", parent_content, re.DOTALL | re.MULTILINE)
        intro = intro_match.group(1).strip() if intro_match else ""

        if intro and len(intro) > 200:
            content = intro + "\n\n" + parent_section
        else:
            content = parent_section

        # Don't append local content if it's just test instructions
        if local_content and "run the tests" not in local_content.lower()[:200]:
            content += "\n\n" + local_content
    elif local_content:
        content = local_content
    elif grandparent_section:
        content = grandparent_section
    else:
        content = f"# {lab_path.name}\n\nImplement the {lab_path.name} project."

    return content.strip()


def detect_test_script(lab_path: Path) -> Optional[str]:
    """Find the test script for this lab."""
    # Look for test-*.sh pattern
    for f in lab_path.glob("test-*.sh"):
        return f.name

    # Look for generic test scripts
    for name in ["test.sh", "run-tests.sh", "grade.sh"]:
        if (lab_path / name).exists():
            return name

    return None


def detect_artifacts(lab_path: Path) -> list[str]:
    """Detect expected artifacts (files the student should create)."""
    artifacts = []
    readme_path = lab_path / "README.md"

    if readme_path.exists():
        content = readme_path.read_text()

        # Look for mentions of expected executables
        # Pattern: compile into `name` or compile it into the binary `name`
        matches = re.findall(r"compile.*?(?:into|to)\s+(?:the\s+)?(?:binary\s+)?`?(\w+)`?", content, re.IGNORECASE)
        artifacts.extend(matches)

        # Pattern: you should write the program `name.c`
        matches = re.findall(r"write\s+(?:the\s+)?program\s+`?(\w+\.c)`?", content, re.IGNORECASE)
        artifacts.extend(matches)

        # Pattern: create `name.c`
        matches = re.findall(r"create\s+`?(\w+\.c)`?", content, re.IGNORECASE)
        artifacts.extend(matches)

    # Use lab name as default artifact
    if not artifacts:
        artifacts = [f"{lab_path.name}.c"]

    return list(set(artifacts))


def generate_task_id(lab_path: Path) -> str:
    """Generate a task ID from the lab path."""
    # Convert path like initial-utilities/wcat to task_initial_utilities_wcat
    parts = lab_path.parts
    # Take last 2-3 parts
    relevant_parts = parts[-2:] if len(parts) >= 2 else parts
    task_id = "_".join(relevant_parts).replace("-", "_")
    return f"task_{task_id}"


def generate_config(
    course_id: str,
    lab_path: Path,
    timeout_minutes: int = 20,
    tags: Optional[list[str]] = None,
) -> dict:
    """Generate config.json content."""
    task_id = generate_task_id(lab_path)
    instance_id = f"{course_id}__{task_id.replace('task_', '')}"

    artifacts = detect_artifacts(lab_path)
    lab_type = detect_lab_type(lab_path)

    default_tags = ["operating-systems", "c"]
    if lab_type == "xv6":
        default_tags.append("xv6")

    if tags:
        default_tags.extend(tags)

    # Add tags based on lab name
    lab_name_lower = lab_path.name.lower()
    if "shell" in lab_name_lower:
        default_tags.append("shell")
    if "thread" in lab_name_lower:
        default_tags.append("concurrency")
    if "map" in lab_name_lower or "reduce" in lab_name_lower:
        default_tags.append("mapreduce")
    if "web" in lab_name_lower:
        default_tags.append("networking")

    return {
        "instance_id": instance_id,
        "course_id": course_id,
        "timeout_minutes": timeout_minutes,
        "tags": list(set(default_tags)),
        "artifacts": artifacts,
    }


def generate_compose_yaml(lab_type: str) -> str:
    """Generate compose.yaml content."""
    if lab_type == "xv6":
        return """services:
  default:
    image: ubuntu:22.04
    command: sleep infinity
    working_dir: /workspace
    x-init:
      - preprocess.sh
"""
    else:
        return """services:
  default:
    image: gcc:12
    command: sleep infinity
    working_dir: /workspace
    x-init:
      - preprocess.sh
    x-local:
      CFLAGS: "-Wall -Werror -O2"
"""


def generate_preprocess_script(
    github_url: str,
    commit_hash: str,
    lab_path: Path,
    lab_type: str,
    test_script: Optional[str],
) -> str:
    """Generate preprocess.sh content."""
    lab_relative = str(lab_path)

    # Determine protected files
    protected_files = []
    if test_script:
        protected_files.append(f'"{test_script}"')

    protected_files_str = "\n  ".join(protected_files) if protected_files else ""

    script = f'''#!/bin/bash
set -e

echo "=== Setting up OSTEP Lab: {lab_path.name} ==="

cd /workspace

echo "Installing git"
apt-get update > /dev/null 2>&1
apt-get install -y git > /dev/null 2>&1

echo "Cloning repository"
git clone {github_url} ostep-projects > /dev/null 2>&1
cd ostep-projects
git checkout {commit_hash} > /dev/null 2>&1

echo "Removing git history"
rm -rf .git

echo "Creating checksums for protected files"
cd {lab_relative}

mkdir -p /tmp/checksums
CHECKSUM_FILE=/tmp/checksums/protected.sha256
: > "$CHECKSUM_FILE"
'''

    if protected_files:
        script += f'''
PROTECTED_FILES=(
  {protected_files_str}
)

for file in "${{PROTECTED_FILES[@]}}"; do
  if [ -f "$file" ]; then
    sha256sum "$file" >> "$CHECKSUM_FILE"
    echo "  Protected: $file"
  fi
done
'''

    script += '''
if [ -d tests ]; then
  find tests -type f | sort | while IFS= read -r file; do
    sha256sum "$file" >> "$CHECKSUM_FILE"
    echo "  Protected: $file"
  done
fi

echo "Setup complete"
exit 0
'''
    return script


def generate_evaluate_script(
    lab_path: Path,
    test_script: Optional[str],
    lab_type: str,
) -> str:
    """Generate evaluate.sh content."""
    lab_relative = str(lab_path)
    lab_name = lab_path.name

    # Determine the binary name (usually same as lab folder name)
    binary_name = lab_name.replace("-", "")
    if binary_name.startswith("w"):
        binary_name = binary_name  # wcat, wgrep, etc.

    script = f'''#!/bin/bash
set -e

echo "=== Evaluation ==="

cd /workspace/ostep-projects/{lab_relative}

echo "Verifying protected files were not modified"
if [ -f /tmp/checksums/protected.sha256 ]; then
  sha256sum -c /tmp/checksums/protected.sha256 || {{
    echo "FAIL: Protected files were modified"
    exit 1
  }}
fi
echo "All protected files unchanged"

echo "Running tests (up to 3 attempts to handle timeouts)"

MAX_ATTEMPTS=3
for attempt in $(seq 1 $MAX_ATTEMPTS); do
    echo "Attempt $attempt of $MAX_ATTEMPTS"

    # Clean previous build artifacts
    rm -f {binary_name} *.o 2>/dev/null || true

    echo "Building {binary_name}"
    if [ -f Makefile ]; then
        if timeout 300 make; then
            BUILD_SUCCESS=1
        else
            BUILD_SUCCESS=0
        fi
    else
        if timeout 300 gcc -D_GNU_SOURCE -std=gnu11 -Wall -Werror -O2 -o {binary_name} *.c; then
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
'''

    if test_script:
        script += f'''    if timeout 600 bash {test_script} 2>&1 | tee test_output.txt; then
        echo "PASS: All tests passed on attempt $attempt"
        exit 0
    fi
'''
    else:
        # Fallback to tester framework
        script += '''    if timeout 600 ../../tester/run-tests.sh 2>&1 | tee test_output.txt; then
        echo "PASS: All tests passed on attempt $attempt"
        exit 0
    fi
'''

    script += '''
    if [ $attempt -lt $MAX_ATTEMPTS ]; then
        echo "Tests failed, retrying..."
        rm -f test_output.txt 2>/dev/null || true
        sleep 2
    fi
done

echo "FAIL: Tests failed after $MAX_ATTEMPTS attempts"
exit 1
'''
    return script


def update_courses_json(data_dir: Path, course_id: str, course_name: str, institution: str, year: int):
    """Update courses.json with the new course if not already present."""
    courses_path = data_dir / "courses.json"

    if courses_path.exists():
        with open(courses_path) as f:
            courses_data = json.load(f)
    else:
        courses_data = {"courses": []}

    # Check if course already exists
    existing_course = None
    for course in courses_data["courses"]:
        if course["course_id"] == course_id:
            existing_course = course
            break

    if existing_course:
        # Increment task count
        existing_course["num_tasks"] = existing_course.get("num_tasks", 0) + 1
        print(f"Updated course {course_id}: now has {existing_course['num_tasks']} tasks")
    else:
        # Add new course
        courses_data["courses"].append({
            "course_id": course_id,
            "name": course_name,
            "institution": institution,
            "year": year,
            "num_tasks": 1,
        })
        print(f"Added new course: {course_id}")

    with open(courses_path, "w") as f:
        json.dump(courses_data, f, indent=2)
        f.write("\n")


def add_ostep_lab(
    github_url: str,
    lab_path_str: str,
    course_id: str,
    course_name: str,
    institution: str,
    year: int = 2019,
    timeout_minutes: int = 20,
    tags: Optional[list[str]] = None,
    local_repo: Optional[str] = None,
    dry_run: bool = False,
):
    """Main function to add an OSTEP lab to the benchmark."""
    script_dir = Path(__file__).parent
    data_dir = script_dir / "data"

    # Use local repo or clone to temp directory
    if local_repo:
        repo_path = Path(local_repo)
        commit_hash = get_commit_hash(repo_path)
    else:
        temp_dir = tempfile.mkdtemp(prefix="ostep_lab_")
        repo_path = clone_repo(github_url, Path(temp_dir) / "repo")
        commit_hash = get_commit_hash(repo_path)

    lab_path = Path(lab_path_str)
    full_lab_path = repo_path / lab_path

    if not full_lab_path.exists():
        raise FileNotFoundError(f"Lab path not found: {full_lab_path}")

    # Detect lab characteristics
    lab_type = detect_lab_type(full_lab_path)
    test_script = detect_test_script(full_lab_path)

    print(f"\n=== Lab Analysis ===")
    print(f"Lab path: {lab_path}")
    print(f"Lab type: {lab_type}")
    print(f"Test script: {test_script or 'Not found (will use tester framework)'}")
    print(f"Commit: {commit_hash[:8]}")

    # Check for parent README
    parent_readme = full_lab_path.parent / "README.md"
    if not parent_readme.exists():
        parent_readme = None

    # Generate files
    task_id = generate_task_id(lab_path)
    task_dir = data_dir / course_id / task_id

    config = generate_config(course_id, lab_path, timeout_minutes, tags)
    task_md = extract_task_description(full_lab_path, parent_readme)
    compose_yaml = generate_compose_yaml(lab_type)
    preprocess_sh = generate_preprocess_script(github_url, commit_hash, lab_path, lab_type, test_script)
    evaluate_sh = generate_evaluate_script(lab_path, test_script, lab_type)

    print(f"\n=== Generated Files ===")
    print(f"Task directory: {task_dir}")
    print(f"Config: {json.dumps(config, indent=2)}")

    if dry_run:
        print("\n[DRY RUN] Would create:")
        print(f"  - {task_dir}/config.json")
        print(f"  - {task_dir}/task.md ({len(task_md)} chars)")
        print(f"  - {task_dir}/compose.yaml")
        print(f"  - {task_dir}/preprocess.sh")
        print(f"  - {task_dir}/evaluate.sh")
        return

    # Create task directory and files
    task_dir.mkdir(parents=True, exist_ok=True)

    (task_dir / "config.json").write_text(json.dumps(config, indent=2) + "\n")
    (task_dir / "task.md").write_text(task_md + "\n")
    (task_dir / "compose.yaml").write_text(compose_yaml)
    (task_dir / "preprocess.sh").write_text(preprocess_sh)
    (task_dir / "evaluate.sh").write_text(evaluate_sh)

    # Make scripts executable
    os.chmod(task_dir / "preprocess.sh", 0o755)
    os.chmod(task_dir / "evaluate.sh", 0o755)

    # Update courses.json
    update_courses_json(data_dir, course_id, course_name, institution, year)

    print(f"\n=== Success ===")
    print(f"Lab added: {task_id}")
    print(f"Location: {task_dir}")
    print(f"\nNext steps:")
    print(f"  1. Review generated files, especially task.md")
    print(f"  2. Test with: inspect eval courselab.py --task-ids {config['instance_id']}")


def main():
    parser = argparse.ArgumentParser(
        description="Add OSTEP/CS537 labs to courselab_bench",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Add wcat from initial-utilities
  python add_ostep_lab.py \\
    --github-url https://github.com/remzi-arpacidusseau/ostep-projects \\
    --lab-path initial-utilities/wcat \\
    --course-id cs537-ostep \\
    --course-name "UW-Madison CS537: Operating Systems (OSTEP)" \\
    --institution "UW-Madison"

  # Add from local clone
  python add_ostep_lab.py \\
    --github-url https://github.com/remzi-arpacidusseau/ostep-projects \\
    --lab-path processes-shell \\
    --local-repo /home/qi/ostep-projects \\
    --course-id cs537-ostep

  # Dry run to preview
  python add_ostep_lab.py \\
    --github-url https://github.com/remzi-arpacidusseau/ostep-projects \\
    --lab-path concurrency-webserver \\
    --course-id cs537-ostep \\
    --dry-run
""",
    )

    parser.add_argument(
        "--github-url",
        required=True,
        help="GitHub URL of the OSTEP projects repository",
    )
    parser.add_argument(
        "--lab-path",
        required=True,
        help="Path to the lab within the repository (e.g., 'initial-utilities/wcat')",
    )
    parser.add_argument(
        "--course-id",
        default="cs537-ostep",
        help="Course ID for the benchmark (default: cs537-ostep)",
    )
    parser.add_argument(
        "--course-name",
        default="UW-Madison CS537: Operating Systems (OSTEP)",
        help="Full course name",
    )
    parser.add_argument(
        "--institution",
        default="UW-Madison",
        help="Institution name",
    )
    parser.add_argument(
        "--year",
        type=int,
        default=2019,
        help="Course year (default: 2019)",
    )
    parser.add_argument(
        "--timeout",
        type=int,
        default=20,
        help="Timeout in minutes (default: 20)",
    )
    parser.add_argument(
        "--tags",
        nargs="*",
        help="Additional tags for the lab",
    )
    parser.add_argument(
        "--local-repo",
        help="Path to local repository clone (skips git clone)",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Preview what would be created without writing files",
    )

    args = parser.parse_args()

    try:
        add_ostep_lab(
            github_url=args.github_url,
            lab_path_str=args.lab_path,
            course_id=args.course_id,
            course_name=args.course_name,
            institution=args.institution,
            year=args.year,
            timeout_minutes=args.timeout,
            tags=args.tags,
            local_repo=args.local_repo,
            dry_run=args.dry_run,
        )
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
