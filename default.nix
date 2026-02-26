final: prev:

let
  lib-custom = import ./lib prev.lib;
in
lib-custom.recursiveExtend prev (import ./packages { pkgs = prev; })
