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
in
lib.strings.toJSON (
  lib.mapAttrs (
    url:
    {
      type ? "git",
      ...
    }@args:
    (attrs: { inherit type; } // args // (lib.filterAttrs (n: _: n == "narHash" || n == "rev") attrs)) (
      fetchTree (
        filterTreeArgs type args
        // {
          inherit type url;
        }
        // (lib.optionalAttrs args.lockedRev or false { inherit (args) rev; })
      )
    )
  ) (lib.strings.fromJSON json)
)
