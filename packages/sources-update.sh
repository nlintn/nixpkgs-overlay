#!/usr/bin/env sh
set -eu -o pipefail
builtin cd -- $(dirname $0)
echo " + $(pwd)/$(basename $0)"

export NIX_PATH="nixpkgs=flake:$(nix-instantiate --eval --expr --raw '(builtins.getFlake (builtins.toString ./..)).inputs.nixpkgs.outPath')"

json=$(nix-build --no-out-link --expr \
    'let pkgs = import <nixpkgs> {}; in (pkgs.formats.json {}).generate "sources" (
        builtins.mapAttrs (url: {type ? "git", ...} @ args:
            (attrs: args // (pkgs.lib.filterAttrs (n: _: n == "narHash" || n == "rev" || n == "submodules" ) attrs))
            (builtins.fetchTree { inherit type url; }))
        (builtins.fromJSON (builtins.readFile ./sources.json)))' \
    ) &&
cat $json > sources.json
echo "updated $(pwd)/sources.json"

for f in $(find -regex './.*/sources-update\.sh'); do "$f"; done
