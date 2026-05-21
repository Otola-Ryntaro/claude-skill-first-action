#!/usr/bin/env bash
# Phase 0 preflight gate for first-action skill.
# Prints one line starting with either "OK:" or "BLOCK:" plus reason(s).

set -u

dir="$(pwd)"
reasons=()

# 1. Existing .git
if [ -d ".git" ]; then
  reasons+=(".git already exists")
fi

# 2. Known project markers
for marker in CLAUDE.md package.json pyproject.toml Cargo.toml go.mod Gemfile composer.json; do
  if [ -e "$marker" ]; then
    reasons+=("$marker present")
  fi
done

# 3. More than 5 files already (excluding hidden)
file_count=$(ls -1 2>/dev/null | wc -l | tr -d ' ')
if [ "$file_count" -ge 5 ]; then
  reasons+=("$file_count files already present")
fi

if [ ${#reasons[@]} -eq 0 ]; then
  echo "OK: $dir is clean"
  exit 0
else
  IFS='; '
  echo "BLOCK: ${reasons[*]}"
  exit 1
fi
