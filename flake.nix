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
      packages = (system:
        let 
          pkgs = nixpkgs.legacyPackages.${system};
        in rec {
          isabelle2023-vsce = pkgs.callPackage ./packages/isabelle2023-vsce.nix {};
          isabelle2024-rc1 = pkgs.callPackage ./packages/isabelle2024-rc1.nix {};
          isabelle2024-rc1-vsce = pkgs.callPackage ./packages/isabelle2024-rc1-vsce.nix { inherit isabelle2024-rc1; };
          nixln-edit = inputs.nixln-edit.packages.${system}.nixln-edit;
        });
    in {
      overlays.default = (final: prev: packages prev.system);
      packages = eachSystem (system: packages system);
    };
}
