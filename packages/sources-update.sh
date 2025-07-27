#!/usr/bin/env sh
builtin cd -- $(dirname $0)
json=$(nix-instantiate --eval --raw --expr \
    'builtins.toJSON (builtins.mapAttrs (url: {type ? "Git", ...}:
        ({rev, narHash, ...}: { inherit type rev narHash; }) (builtins.${"fetch${type}"} { inherit url; }))
        (builtins.fromJSON (builtins.readFile ./sources.json)))' \
    ) &&
echo $json > sources.json
