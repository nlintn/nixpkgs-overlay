{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    nixln-edit = {
      url = "github:nlintn/nixln-edit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
      eachSystemPkgs = f: builtins.mapAttrs (_: f) (lib.genAttrs (builtins.attrNames nixpkgs.legacyPackages) (system: import nixpkgs { inherit system; }));
    in {
      overlays.default = import ./overlay-fun.nix { inherit self; };
      packages = eachSystemPkgs (pkgs: import ./packages { inherit pkgs self; });
      lib = import ./lib lib;
    };
}
