lib:

let
  main = rec {
    capitalizeString = str: (
      (lib.toUpper (lib.substring 0 1 str))
      +
      (lib.substring 1 ((lib.stringLength str) - 1) str)
    );
    eachSystem = nixpkgs: lib.genAttrs (builtins.attrNames nixpkgs.legacyPackages);
    eachSystemPkgs = nixpkgs: f: builtins.mapAttrs (_: f) (eachSystem nixpkgs (system: import nixpkgs { inherit system; }));
  };
  lib' = lib // main;
in main // {
  hyprland = import ./hyprland lib';
}
