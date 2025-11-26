{ pkgs ? import <nixpkgs> {} }:

let
  lib = pkgs.lib;
  lib' = import ../lib lib;

  sources = builtins.fromJSON (builtins.readFile ./sources.json);
  fetchSources = url: (builtins.fetchTree (sources.${url} // { inherit url; }));

  pkgs' = pkgs.extend (_: _: { inherit fetchSources; });

  withArgs = f: pkg: self: f pkg (builtins.intersectAttrs (builtins.functionArgs pkg) self);

  by-path-files = builtins.filter (f: lib.hasSuffix "default.nix" f) (lib.filesystem.listFilesRecursive ./by-path);
  by-path = self: lib'.filesToAttrs (f: withArgs pkgs'.callPackage (import f fetchSources) self) ./by-path "default.nix" by-path-files;

  firefoxAddons = self: withArgs pkgs'.callPackages (import ./firefoxAddons) self;

  merged = self: by-path self // { firefoxAddons = firefoxAddons self; };
in
  lib.fix merged
