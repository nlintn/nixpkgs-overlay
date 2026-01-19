final: prev:

let
  lib' = import ./lib prev.lib;
in
lib'.recursiveExtend prev (import ./packages { pkgs = prev; })
