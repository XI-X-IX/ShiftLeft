#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f package.json ]]; then
  echo "package.json not found in the current directory. Run this from your Node.js project root." >&2
  exit 1
fi

if [[ ! -f package-lock.json && ! -f npm-shrinkwrap.json ]]; then
  echo "No lockfile found. npm audit works best with package-lock.json or npm-shrinkwrap.json." >&2
fi

npm audit --audit-level=high
