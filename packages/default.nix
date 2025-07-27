{ pkgs ? import <nixpkgs> {} }:

let
  lib = pkgs.lib;
  lib' = import ../lib lib;

  sources = builtins.fromJSON (builtins.readFile ./sources.json);
  fetchSources = url: with sources.${url}; (builtins.${"fetch${type}"} { inherit url rev narHash; }) // sources.${url};

  files = builtins.filter (f: lib.hasSuffix ".nix" f && f != (builtins.toString ./default.nix)) (lib'.readDirRecursive ./.);
in
  lib'.nixFilesToAttrs (f: pkgs.callPackage (import f fetchSources) {}) ./. files
