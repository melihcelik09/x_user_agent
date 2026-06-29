#!/usr/bin/env bash

set -euo pipefail

if [[ ! -f pubspec.yaml ]]; then
  echo "pubspec.yaml not found. Run this script from the package root." >&2
  exit 1
fi

version="$(sed -nE 's/^version:[[:space:]]*([^[:space:]]+)[[:space:]]*$/\1/p' pubspec.yaml | head -n 1)"

if [[ -z "${version}" ]]; then
  echo "Could not read version from pubspec.yaml." >&2
  exit 1
fi

tag="v${version}"

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "Working tree is not clean. Commit or stash changes before tagging." >&2
  exit 1
fi

if git rev-parse "${tag}" >/dev/null 2>&1; then
  echo "Tag ${tag} already exists locally." >&2
  exit 1
fi

if git ls-remote --exit-code --tags origin "refs/tags/${tag}" >/dev/null 2>&1; then
  echo "Tag ${tag} already exists on origin." >&2
  exit 1
fi

git tag "${tag}"
echo "Created tag ${tag}"

if [[ "${1:-}" == "--push" ]]; then
  git push origin "${tag}"
  echo "Pushed ${tag}"
else
  echo "Run: git push origin ${tag}"
fi
