lib:

let
  main = rec {
    attrsToListRecursive =
      attrs:
      let
        concatNames = n: lib.map ({ name, value }: lib.nameValuePair ([ n ] ++ name) value);
        aux =
          attrs:
          lib.flatten (
            lib.mapAttrsToList (
              n: v:
              if lib.isAttrs v && !lib.isDerivation v then concatNames n (aux v) else lib.nameValuePair [ n ] v
            ) attrs
          );
      in
      aux attrs;
    capitalizeString =
      str: ((lib.toUpper (lib.substring 0 1 str)) + (lib.substring 1 ((lib.stringLength str) - 1) str));
    eachSystem = nixpkgs: lib.genAttrs (lib.attrNames nixpkgs.legacyPackages);
    eachSystemPkgs =
      nixpkgs: f: lib.mapAttrs (_: f) (eachSystem nixpkgs (system: import nixpkgs { inherit system; }));
    filesToAttrs =
      f: prefix_to_remove: suffix_to_remove: files:
      let
        prefix_to_remove' = toString prefix_to_remove;
        suffix_to_remove' = toString suffix_to_remove;
        attr_paths = lib.map (
          file':
          let
            file = toString file';
          in
          {
            attr_path =
              let
                path_list = lib.splitString "/" (
                  lib.removeSuffix suffix_to_remove' (lib.removePrefix prefix_to_remove' file)
                );
              in
              lib.sublist 1 (lib.length path_list - 2) path_list;
            value = f file;
          }
        ) files;
      in
      lib.foldl lib.recursiveUpdate { } (
        lib.map ({ attr_path, value }: lib.setAttrByPath attr_path value) attr_paths
      );
    recursiveExtend =
      base: override:
      lib.mapAttrs (
        n: v:
        if base ? ${n} && base.${n} ? extend then
          base.${n}.extend (final: prev: recursiveExtend prev v)
        else
          v
      ) override;
    safeGetExe = x: lib.escapeShellArg (lib.getExe x);
    safeGetExe' = x: name: lib.escapeShellArg (lib.getExe' x name);
  };
  lib' = lib // main;
in
main
// {
  hyprland = import ./hyprland lib';
}
