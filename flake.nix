{
  outputs = { self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
      lib' = import ./lib lib;
    in {
      overlays.default = import ./.;
      legacyPackages = lib'.eachSystemPkgs nixpkgs (pkgs: import ./packages { inherit pkgs; });
      test = lib'.eachSystemPkgs nixpkgs (pkgs: import ./test.nix pkgs self);
      lib = lib';
      lib' = lib';
      homeManagerModule = import ./homeManagerModule;
      homeManagerModules.default = self.homeManagerModule;
    };

  inputs = {
    nixpkgs.url = "nixpkgs";
  };
}
