{ lib, ... }:

let
  lib' = import ../lib lib;
  files = builtins.filter (f: f != builtins.toString ./default.nix) (lib'.readDirRecursive ./.);
in {
  imports = files;
}
