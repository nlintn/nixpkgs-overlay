lib:

let
  main = rec {
    attrsToListRecursive = attrs:
      let aux = lib.mapAttrsToList (_: v: if builtins.isAttrs v && !lib.isDerivation v then aux v else v);
      in lib.flatten (aux attrs);
    capitalizeString = str: (
      (lib.toUpper (lib.substring 0 1 str))
      +
      (lib.substring 1 ((lib.stringLength str) - 1) str)
    );
    eachSystem = nixpkgs: lib.genAttrs (builtins.attrNames nixpkgs.legacyPackages);
    eachSystemPkgs = nixpkgs: f: builtins.mapAttrs (_: f) (eachSystem nixpkgs (system: import nixpkgs { inherit system; }));
    filesToAttrs = f: prefix_to_remove: suffix_to_remove: files:
      let
        prefix_to_remove' = builtins.toString prefix_to_remove;
        suffix_to_remove' = builtins.toString suffix_to_remove;
        attr_paths = builtins.map (file': let file = builtins.toString file'; in {
          attr_path = let
            path_list = lib.splitString "/" (lib.removeSuffix suffix_to_remove' (lib.removePrefix prefix_to_remove' file));
          in lib.sublist 1 (builtins.length path_list - 2) path_list;
          value = f file;
        }) files;
      in builtins.foldl' lib.recursiveUpdate {} (builtins.map ({ attr_path, value }: lib.setAttrByPath attr_path value) attr_paths);
    recursiveExtend = base: override:
      builtins.mapAttrs (n: v: if base ? ${n} && base.${n} ? extend then base.${n}.extend (final: prev: recursiveExtend prev v) else v) override;
  };
  lib' = lib // main;
in main // {
  hyprland = import ./hyprland lib';
}
