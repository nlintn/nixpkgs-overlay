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
      lib' = import ./lib lib;
    in {
      overlays.default = import ./overlay-fun.nix { inherit self; };
      packages = lib'.eachSystemPkgs nixpkgs (pkgs: import ./packages { inherit pkgs self; });
      lib = lib';
    };
}
