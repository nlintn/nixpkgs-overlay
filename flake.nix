{
  outputs =
    { self, nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      lib-custom = import ./lib lib;
    in
    {
      overlays.default = import ./.;
      legacyPackages = lib-custom.eachSystemPkgs nixpkgs (pkgs: import ./packages { inherit pkgs; });

      checks = lib-custom.eachSystemPkgs nixpkgs (pkgs: rec {
        build = import ./check-build.nix pkgs self;
        default = build;
      });

      lib = lib-custom;
      inherit lib-custom;
      homeManagerModule = import ./homeManagerModule;
      homeManagerModules.default = self.homeManagerModule;
    };

  inputs = {
    nixpkgs.url = "nixpkgs";
  };
}
