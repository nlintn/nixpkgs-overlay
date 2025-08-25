lib:

let
  main = rec {
    attrsToListRecursive = attrs:
      let aux = lib.mapAttrsToList (_: v: if builtins.isAttrs v && (v.type or "" != "derivation") then aux v else v);
      in lib.flatten (aux attrs);
    capitalizeString = str: (
      (lib.toUpper (lib.substring 0 1 str))
      +
      (lib.substring 1 ((lib.stringLength str) - 1) str)
    );
    eachSystem = nixpkgs: lib.genAttrs (builtins.attrNames nixpkgs.legacyPackages);
    eachSystemPkgs = nixpkgs: f: builtins.mapAttrs (_: f) (eachSystem nixpkgs (system: import nixpkgs { inherit system; }));
    nixFilesToAttrs = f: prefix_to_remove: files:
      let
        cwd_len = builtins.length (lib.splitString "/" (builtins.toString prefix_to_remove));
        attr_paths = builtins.map (file': let file = builtins.toString file'; in {
          attr_path = let fp = (lib.splitString "/" file); apr = lib.reverseList (lib.sublist cwd_len (builtins.length fp) fp);
            in lib.reverseList ([ (lib.removeSuffix ".nix" (builtins.head apr)) ] ++ (if apr == [] then [] else builtins.tail apr));
          value = f file;
        }) files;
      in builtins.foldl' lib.recursiveUpdate {} (builtins.map ({ attr_path, value }: lib.setAttrByPath attr_path value) attr_paths);
  };
  lib' = lib // main;
in main // {
  hyprland = import ./hyprland lib';
}
