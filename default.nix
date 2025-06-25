{ self ? null }:

final: prev: prev.lib.recursiveUpdate prev (import ./packages.nix { pkgs = prev; inherit self; })
