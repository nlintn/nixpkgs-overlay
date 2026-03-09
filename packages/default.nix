{
  pkgs ? import <nixpkgs> { },
}:

let
  inherit (pkgs) lib;
  lib-custom = import ../lib lib;

  sources = lib.strings.fromJSON (lib.readFile ./sources.json);
  fetchSources =
    url:
    (fetchTree (
      (lib.filterAttrs (n: _: !lib.elem n [ "lockedRev" ]) sources.${url}) // { inherit url; }
    ));

  pkgs' =
    self: pkgs.extend (_: prev: lib-custom.recursiveExtend prev (self // { inherit fetchSources; }));

in
lib.fix (
  self:
  lib.mergeAttrsList [
    (lib.packagesFromDirectoryRecursive {
      callPackage = (f: (pkgs' self).callPackage (import f fetchSources pkgs));
      directory = ./by-path;
    })
    { inherit lib-custom; }
  ]
)
