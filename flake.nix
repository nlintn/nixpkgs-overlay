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
          isabelle2024-nvim-lsp = pkgs.callPackage ./packages/isabelle/isabelle2024-nvim-lsp.nix {};
          nixln-edit = inputs.nixln-edit.packages.${system}.nixln-edit;
        });
    in {
      overlays.default = (final: prev: packages prev.system);
      packages = eachSystem (system: packages system);
    };
}
