#!/usr/bin/env bash

set -eu -o pipefail

BASE_PATH="$(dirname "${0}")"
echo -e " + ${0}\n"

export NIXPKGS NIX_PATH
NIXPKGS="$(nix-instantiate --eval --raw --argstr basePath "${BASE_PATH}" \
    --expr '{ basePath }: (builtins.getFlake (builtins.toString ./${basePath}/..)).inputs.nixpkgs.outPath')"
NIX_PATH="nixpkgs=flake:${NIXPKGS}"

prev_json="$(< "${BASE_PATH}/sources.json")"
nix-instantiate --option substitute false --eval --raw --argstr json "${prev_json}" --argstr nixpkgs "$NIXPKGS" "${BASE_PATH}/sources-update.nix" \
    | jq --sort-keys . > "${BASE_PATH}/sources.json"

echo -e "updated ${BASE_PATH}/sources.json"
diff --color --ignore-all-space --initial-tab --unified=1 <(jq --sort-keys . <<< "${prev_json}") "${BASE_PATH}/sources.json" || :
echo

find "${BASE_PATH}" -regex "${BASE_PATH}/.*/sources-update\.sh" -exec '{}' ';'
