#!/usr/bin/env bash
set -u

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "$script_dir/.." && pwd)"
cache_dir="${HOME}/.cache/base-motion-kit"
today="$(date +%Y-%m-%d)"

mkdir -p "$cache_dir"
cache_key="$(printf '%s' "$repo_dir" | shasum | awk '{print $1}')"
stamp_file="$cache_dir/last-update-check-$cache_key"

cd "$repo_dir" || exit 0

if [ ! -d .git ]; then
  echo "BASE_MOTION_KIT_UPDATE_WARN: not a git checkout; cannot compare with remote"
  echo "Reinstall with git clone to enable update checks:"
  echo "  git clone https://github.com/wy77308792/Base-Motion-Kit.git \"$repo_dir\""
  exit 0
fi

if [ "${BASE_MOTION_KIT_FORCE_UPDATE_CHECK:-0}" != "1" ] && [ -f "$stamp_file" ] && [ "$(cat "$stamp_file" 2>/dev/null)" = "$today" ]; then
  echo "BASE_MOTION_KIT_UPDATE_SKIP: already checked today"
  exit 0
fi

remote_name="$(git remote 2>/dev/null | head -1)"
if [ -z "$remote_name" ]; then
  echo "BASE_MOTION_KIT_UPDATE_SKIP: no git remote"
  printf '%s' "$today" > "$stamp_file"
  exit 0
fi

if ! git fetch --quiet "$remote_name" 2>/dev/null; then
  echo "BASE_MOTION_KIT_UPDATE_WARN: failed to fetch remote; continue with local version"
  exit 0
fi

local_ref="$(git rev-parse HEAD 2>/dev/null || true)"
upstream_ref="$(git rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null || true)"

if [ -n "$upstream_ref" ]; then
  remote_ref="$(git rev-parse "$upstream_ref" 2>/dev/null || true)"
  remote_label="$upstream_ref"
else
  current_branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || true)"
  remote_label="$remote_name/${current_branch:-main}"
  remote_ref="$(git rev-parse "$remote_label" 2>/dev/null || git rev-parse "$remote_name/main" 2>/dev/null || true)"
fi

printf '%s' "$today" > "$stamp_file"

if [ -z "$local_ref" ] || [ -z "$remote_ref" ]; then
  echo "BASE_MOTION_KIT_UPDATE_WARN: cannot compare local and remote refs"
  exit 0
fi

if [ "$local_ref" = "$remote_ref" ]; then
  echo "BASE_MOTION_KIT_UPDATE_OK: local skill is up to date"
  exit 0
fi

if git merge-base --is-ancestor "$local_ref" "$remote_ref" 2>/dev/null; then
  echo "BASE_MOTION_KIT_UPDATE_AVAILABLE: remote has a newer version ($remote_label)"
  echo "Run: cd \"$repo_dir\" && git pull --ff-only"
  exit 0
fi

echo "BASE_MOTION_KIT_UPDATE_DIVERGED: local skill differs from remote ($remote_label)"
echo "Review before updating: cd \"$repo_dir\" && git status && git log --oneline --left-right HEAD...$remote_label"
