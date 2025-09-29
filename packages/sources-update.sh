#!/usr/bin/env bash
set -eu -o pipefail
builtin cd -- "$(dirname "$0")"
echo -e " + $(pwd)/$(basename "$0")\n"

export NIXPKGS NIX_PATH
NIXPKGS="$(nix-instantiate --eval --expr --raw '(builtins.getFlake (builtins.toString ./..)).inputs.nixpkgs.outPath')"
NIX_PATH="nixpkgs=flake:$NIXPKGS"

prev_json=$(cat sources.json)
json=$(nix-instantiate --option substitute false --eval --raw --argstr nixpkgs "$NIXPKGS" --expr '
    { nixpkgs }:
    let
        pkgs = import nixpkgs {};
    in builtins.toJSON (
        builtins.mapAttrs (url: { type ? "git", ... } @ args:
            (attrs: { inherit type; } // args // (pkgs.lib.filterAttrs (n: _: n == "narHash" || n == "rev" || n == "submodules" ) attrs))
            (builtins.fetchTree { inherit type url; }))
        (builtins.fromJSON (builtins.readFile ./sources.json)))'
)
echo "$json" | jq --sort-keys . > sources.json
echo -e "updated $(pwd)/sources.json"
diff --color --ignore-all-space --initial-tab --unified=1 <(echo "$prev_json" | jq --sort-keys .) sources.json || true
echo

find . -regex './.*/sources-update\.sh' -exec '{}' ';'
