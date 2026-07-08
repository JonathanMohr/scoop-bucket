#!/usr/bin/env bash
set -euo pipefail

# Usage: ./get_sha256.sh <url>

URL="${1:?Usage $0 <url>}"

if ! curl -fsSL -o /dev/null -w '%{http_code}' "${URL}" | grep -q '^200$'; then
    echo "Error: Could not find file at: ${URL}" >&2
    exit 1
fi

HASH="$(curl -fsSL "${URL}" | shasum -a 256 | awk '{print $1}')"

if [[ -z "${HASH}" ]]; then
    echo "Error: Failed to compute SHA256 hash." >&2
    exit 1
fi

echo "SHA256: ${HASH}"
