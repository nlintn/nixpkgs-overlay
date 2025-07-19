{ self ? null }:

final: prev: prev.lib.recursiveUpdate prev (import ./packages { pkgs = prev; inherit self; })
