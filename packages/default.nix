{
  pkgs ? import <nixpkgs> { },
}:

let
  inherit (pkgs) lib;
  lib' = import ../lib lib;

  sources = lib.strings.fromJSON (lib.readFile ./sources.json);
  fetchSources = url: (fetchTree (sources.${url} // { inherit url; }));

  pkgs' = self: pkgs.extend (_: prev: lib'.recursiveExtend prev (self // { inherit fetchSources; }));

  by-path =
    self:
    lib.packagesFromDirectoryRecursive {
      callPackage = (f: (pkgs' self).callPackage (import f fetchSources pkgs));
      directory = ./by-path;
    };
in
lib.fix by-path
