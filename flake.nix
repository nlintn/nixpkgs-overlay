{
  outputs = { self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
      lib' = import ./lib lib;
    in {
      overlays.default = import ./.;
      packages = lib'.eachSystemPkgs nixpkgs (pkgs: import ./packages { inherit pkgs; });
      lib = lib';
      lib' = lib';
    };

  inputs = {
    nixpkgs.url = "nixpkgs";
  };
}
