{
  outputs = { self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
      lib' = import ./lib lib;
    in {
      overlays.default = import ./.;
      legacyPackages = lib'.eachSystemPkgs nixpkgs (pkgs: import ./packages { inherit pkgs; });

      checks = lib'.eachSystemPkgs nixpkgs (pkgs: rec {
        build = import ./check-build.nix pkgs self;
        default = build;
      });

      lib = lib';
      lib' = lib';
      homeManagerModule = import ./homeManagerModule;
      homeManagerModules.default = self.homeManagerModule;
    };

  inputs = {
    nixpkgs.url = "nixpkgs";
  };
}
