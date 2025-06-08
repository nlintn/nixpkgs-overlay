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

        vimPlugins = (prev.vimPlugins or {}) // {
          battery-nvim = prev.callPackage ./packages/vimPlugins/battery-nvim.nix { };
          isabelle-syn-nvim = prev.callPackage ./packages/vimPlugins/isabelle-syn-nvim.nix { };
          telescope-tabs = prev.callPackage ./packages/vimPlugins/telescope-tabs.nix { };
        };
      });
      packages = eachSystem (system: nixpkgs.legacyPackages.${system}.extend (overlays.default));
    };
}
