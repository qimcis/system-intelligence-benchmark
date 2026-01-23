#!/usr/bin/env python3
"""
Interactive Lab Addition Tool

A user-friendly interface for adding OSTEP labs to the benchmark.
"""

import sys
from pathlib import Path

# Add parent to path for imports
sys.path.insert(0, str(Path(__file__).parent))

from add_ostep_lab import add_ostep_lab


def get_input(prompt: str, default: str = "") -> str:
    """Get user input with optional default."""
    if default:
        result = input(f"{prompt} [{default}]: ").strip()
        return result if result else default
    return input(f"{prompt}: ").strip()


def main():
    print("=" * 60)
    print("OSTEP Lab Addition Tool")
    print("=" * 60)
    print()

    # GitHub URL
    github_url = get_input(
        "GitHub repository URL",
        "https://github.com/remzi-arpacidusseau/ostep-projects"
    )

    # Local repo (optional)
    local_repo = get_input(
        "Local clone path (optional, press Enter to clone)",
        ""
    )
    if not local_repo:
        local_repo = None

    # Lab path
    print()
    print("Available OSTEP labs (typical paths):")
    print("  C/Linux:")
    print("    - initial-utilities/wcat")
    print("    - initial-utilities/wgrep")
    print("    - initial-utilities/wzip")
    print("    - initial-utilities/wunzip")
    print("    - initial-reverse")
    print("    - processes-shell")
    print("    - concurrency-webserver")
    print("    - concurrency-pzip")
    print("    - concurrency-mapreduce")
    print("    - filesystems-checker")
    print("  xv6:")
    print("    - initial-xv6")
    print("    - scheduling-xv6-lottery")
    print("    - vm-xv6-intro")
    print("    - concurrency-xv6-threads")
    print()

    lab_path = get_input("Lab path within repository (e.g., 'processes-shell')")
    if not lab_path:
        print("Error: Lab path is required")
        return 1

    # Course info
    print()
    course_id = get_input("Course ID", "cs537-ostep")
    course_name = get_input("Course name", "UW-Madison CS537: Operating Systems (OSTEP)")
    institution = get_input("Institution", "UW-Madison")

    # Optional settings
    print()
    timeout = get_input("Timeout (minutes)", "20")
    try:
        timeout = int(timeout)
    except ValueError:
        timeout = 20

    tags_input = get_input("Additional tags (comma-separated, optional)", "")
    tags = [t.strip() for t in tags_input.split(",")] if tags_input else None

    # Confirm
    print()
    print("=" * 60)
    print("Summary:")
    print(f"  GitHub URL: {github_url}")
    print(f"  Lab path: {lab_path}")
    print(f"  Course ID: {course_id}")
    print(f"  Local repo: {local_repo or '(will clone)'}")
    print("=" * 60)
    print()

    confirm = get_input("Proceed? (y/n)", "y")
    if confirm.lower() != "y":
        print("Aborted.")
        return 0

    # Run
    print()
    try:
        add_ostep_lab(
            github_url=github_url,
            lab_path_str=lab_path,
            course_id=course_id,
            course_name=course_name,
            institution=institution,
            timeout_minutes=timeout,
            tags=tags,
            local_repo=local_repo,
        )
    except Exception as e:
        print(f"Error: {e}")
        return 1

    return 0


if __name__ == "__main__":
    sys.exit(main())
