{ pkgs ? import <nixpkgs> {} }:

let
  lib = pkgs.lib;
  lib' = import ../lib lib;

  sources = builtins.fromJSON (builtins.readFile ./sources.json);
  fetchSources = url: (builtins.fetchTree (sources.${url} // { inherit url; }));

  pkgs' = self: pkgs.extend (_: prev: lib'.recursiveExtend prev (self // { inherit fetchSources; }));

  by-path-files = builtins.filter (f: lib.hasSuffix "default.nix" f) (lib.filesystem.listFilesRecursive ./by-path);
  by-path = self: lib'.filesToAttrs (f: (pkgs' self).callPackage (import f fetchSources) {}) ./by-path "default.nix" by-path-files;

  firefoxAddons = self: (pkgs' self).callPackages (import ./firefoxAddons) {};

  merged = self: by-path self // { firefoxAddons = firefoxAddons self; };
in
  lib.fix merged
