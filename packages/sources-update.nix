{ json, nixpkgs }:

let
  pkgs = import nixpkgs {};
  lib = pkgs.lib;
  filterTreeArgs = type: lib.filterAttrs (n: _: builtins.elem n {
    git = [ "url" "ref" "submodules" ];
  }.${type});
in builtins.toJSON (
  builtins.mapAttrs (url: { type ? "git", ... } @ args:
    (attrs: { inherit type; } // args // (lib.filterAttrs (n: _: n == "narHash" || n == "rev") attrs))
    (builtins.fetchTree (filterTreeArgs type args // { inherit type url; })))
  (builtins.fromJSON json))
