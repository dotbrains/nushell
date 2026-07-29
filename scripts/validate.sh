#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$repo_root"

find . -type f -name '*.nu' -not -path '*/.git/*' -print0 |
    while IFS= read -r -d '' file; do
        nu --no-config-file --commands "if not (nu-check --debug '$file') { exit 1 }"
        printf "OK %s\\n" "$file"
    done
