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
    readDirRecursive = cwd:
      let
        cwd' = builtins.toString cwd;
        filterContents = t: builtins.attrNames (lib.filterAttrs (_: v: v == t) (builtins.readDir cwd'));
        f = filterContents "regular"; d = filterContents "directory";
      in (builtins.map (f: "${cwd'}/${f}") f) ++ (lib.flatten (builtins.map (d: readDirRecursive "${cwd'}/${d}") d));
    nixFilesToAttrs = f: cwd: files:
      let
        cwd_len = builtins.length (lib.splitString "/" (builtins.toString cwd));
        attr_paths = builtins.map (file: {
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
