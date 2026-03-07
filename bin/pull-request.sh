#!/usr/bin/env bash
set -euo pipefail

if ! command -v git >/dev/null 2>&1; then
  echo "git is required."
  exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Not inside a git repository."
  exit 1
fi

remote_name="origin"
if ! git remote get-url --push "$remote_name" >/dev/null 2>&1; then
  remote_name="$(git remote | head -n1 || true)"
fi

if [[ -z "$remote_name" ]]; then
  echo "No git remotes found."
  exit 1
fi

remote_url="$(git remote get-url --push "$remote_name")"
owner_repo="$(printf '%s' "$remote_url" \
  | sed -E 's#(git@|https://)github\.com[:/]##; s#\.git$##')"

if [[ "$owner_repo" != */* ]]; then
  echo "Unsupported remote URL for GitHub: $remote_url"
  exit 1
fi

owner="${owner_repo%/*}"
repo="${owner_repo#*/}"
branch="$(git branch --show-current)"

if [[ -z "$branch" ]]; then
  echo "Detached HEAD. Check out a branch first."
  exit 1
fi

default_branch="$(git symbolic-ref --short "refs/remotes/$remote_name/HEAD" 2>/dev/null | sed "s#^$remote_name/##")"
default_branch="${default_branch:-main}"

compare_url="https://github.com/$owner/$repo/compare/$default_branch...$branch"
echo "... creating pull request for branch \"$branch\" and comparing to \"$default_branch\" in \"$owner/$repo\""

if command -v open >/dev/null 2>&1; then
  open "$compare_url"
else
  echo "$compare_url"
fi
