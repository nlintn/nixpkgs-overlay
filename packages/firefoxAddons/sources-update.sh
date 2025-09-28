#!/usr/bin/env bash
set -eu -o pipefail
builtin cd -- "$(dirname "$0")"
echo -e " + $(pwd)/$(basename "$0")\n"

prev_addons=$(cat addons-generated.nix)
nix run --option experimental-features "flakes nix-command" \
    "git+https://git.sr.ht/~rycee/mozilla-addons-to-nix/" addons.json addons-generated.nix
diff --color --ignore-all-space --initial-tab --unified=2 <(echo "$prev_addons") addons-generated.nix || true
echo
