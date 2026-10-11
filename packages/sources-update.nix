{ json, nixpkgs }:

let
  pkgs = import nixpkgs { };
  inherit (pkgs) lib;
  filterTreeArgs =
    type:
    lib.filterAttrs (
      n: _:
      lib.elem n
        {
          git = [
            "url"
            "ref"
            "submodules"
          ];
        }
        .${type}
    );
  fetchers = import ./fetchers.nix;
in
lib.strings.toJSON (
  lib.mapAttrs (
    n:
    {
      type ? "git",
      url ? n,
      ...
    }@args:
    (attrs: { inherit type; } // args // (lib.filterAttrs (n: _: n == "narHash" || n == "rev") attrs)) (
      fetchers.${type} (
        filterTreeArgs type args
        // {
          inherit url;
        }
        // (lib.optionalAttrs args.lockedRev or false { inherit (args) rev; })
      )
    )
  ) (lib.strings.fromJSON json)
)
