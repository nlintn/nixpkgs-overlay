#!/usr/bin/env sh
set -eu -o pipefail
builtin cd -- $(dirname $0)
echo " + $(pwd)/$(basename $0)"

nix run --option experimental-features "flakes nix-command" \
    "git+https://git.sr.ht/~rycee/mozilla-addons-to-nix/" addons.json addons-generated.nix
