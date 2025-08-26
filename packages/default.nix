{ pkgs ? import <nixpkgs> {} }:

let
  lib = pkgs.lib;
  lib' = import ../lib lib;

  sources = builtins.fromJSON (builtins.readFile ./sources.json);
  fetchSources = url: (builtins.fetchTree (sources.${url} // { inherit url; }));

  by-name-files = builtins.filter (f: lib.hasSuffix ".nix" f) (lib.filesystem.listFilesRecursive ./by-name);
  by-name = lib'.nixFilesToAttrs (f: pkgs.callPackage (import f fetchSources) {}) ./by-name by-name-files;

  firefoxAddons = pkgs.callPackages ./firefoxAddons {};

  merged = by-name // { inherit firefoxAddons; };
in
  merged
