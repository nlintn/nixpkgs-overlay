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
      eachSystem = lib.genAttrs (builtins.attrNames nixpkgs.legacyPackages);
    in {
      overlays.default = import ./. { inherit self; };
      packages = eachSystem (system: import ./packages { pkgs = import nixpkgs { inherit system; }; inherit self; });
      lib = import ./lib lib;
    };
}
