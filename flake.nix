{
  outputs =
    { self, nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      lib-custom = import ./lib lib;
      genPkgs = lib-custom.eachSystemPkgs' nixpkgs { allowUnfree = true; } [ ];
    in
    {
      overlays.default = import ./.;
      legacyPackages = genPkgs (pkgs: import ./packages { inherit pkgs; });

      checks = genPkgs (pkgs: rec {
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
