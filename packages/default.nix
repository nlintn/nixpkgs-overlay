{ pkgs ? import <nixpkgs> {} }:

let
  lib = pkgs.lib;
  lib' = import ../lib lib;

  sources = builtins.fromJSON (builtins.readFile ./sources.json);
  fetchSources = url: (builtins.fetchTree (sources.${url} // { inherit url; }));

  by-path-files = builtins.filter (f: lib.hasSuffix "default.nix" f) (lib.filesystem.listFilesRecursive ./by-path);
  by-path = lib'.filesToAttrs (f: pkgs.callPackage (import f fetchSources) {}) ./by-path "default.nix" by-path-files;

  firefoxAddons = pkgs.callPackages ./firefoxAddons {};

  merged = by-path // { inherit firefoxAddons; };
in
  merged
