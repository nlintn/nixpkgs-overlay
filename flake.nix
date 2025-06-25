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
      eachSystem = nixpkgs.lib.genAttrs [ "aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux" ];
    in {
      overlays.default = import ./. { inherit self; };
      packages = eachSystem (system: import ./packages.nix { pkgs = import nixpkgs { inherit system; }; inherit self; });
    };
}
