{
  pkgs ? import <nixpkgs> { },
}:

let
  inherit (pkgs) lib;
  lib-custom = import ../lib lib;

  sources = lib.strings.fromJSON (lib.readFile ./sources.json);
  fetchers = import ./fetchers.nix;
  fetchSources =
    url:
    let
      source = sources.${url};
    in
    (fetchers.${source.type} (
      {
        inherit url;
      }
      // (lib.filterAttrs (
        n: _:
        !lib.elem n [
          "lockedRev"
          "type"
        ]
      ) source)
    ));

  pkgs' = pkgs.extend (_: prev: lib-custom.recursiveExtend prev (self // { inherit fetchSources; }));
  self = lib.mergeAttrsList [
    (lib.packagesFromDirectoryRecursive {
      callPackage = (f: pkgs'.callPackage (import f fetchSources pkgs));
      directory = ./by-path;
    })
    { inherit lib-custom; }
  ];
in
self
