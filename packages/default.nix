{ pkgs ? import <nixpkgs> {} }:

let
  lib = pkgs.lib;
  lib' = import ../lib lib;

  sources = builtins.fromJSON (builtins.readFile ./sources.json);
  fetchSources = url: (builtins.fetchTree (sources.${url} // { inherit url; }));

  files = builtins.filter (f: lib.hasSuffix ".nix" f) (lib'.readDirRecursive ./by-name);
in
  lib'.nixFilesToAttrs (f: pkgs.callPackage (import f fetchSources) {}) ./by-name files
