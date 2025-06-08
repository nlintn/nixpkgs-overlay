{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    nixln-edit = {
      url = "github:nlintn/nixln-edit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs: 
    let 
      eachSystem = nixpkgs.lib.genAttrs [ "aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux" ];
    in rec {
      overlays.default = (final: prev: {
        nixln-edit = inputs.nixln-edit.packages.${final.system}.nixln-edit;
      });
      packages = eachSystem (system: nixpkgs.legacyPackages.${system}.extend (overlays.default));
    };
}
