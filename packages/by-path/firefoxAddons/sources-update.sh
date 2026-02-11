#!/usr/bin/env bash
set -eu -o pipefail

BASE_PATH="$(dirname "${0}")"
echo -e " + ${0}\n"

prev_addons="$(< "${BASE_PATH}/addons-generated.nix")"
nix run --option experimental-features "flakes nix-command" "git+https://git.sr.ht/~rycee/mozilla-addons-to-nix/" \
    "${BASE_PATH}/addons.json" "${BASE_PATH}/addons-generated.nix"

diff --color --ignore-all-space --initial-tab --unified=2 <(echo "$prev_addons") "${BASE_PATH}/addons-generated.nix" || :
echo
