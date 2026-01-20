pkgs: self:

pkgs.symlinkJoin {
  name = "check-build";
  paths =
    let
      lib = pkgs.lib;
      pkgList = lib.filter (p: lib.isDerivation p.value) (
        self.lib.attrsToListRecursive self.legacyPackages.${pkgs.stdenv.hostPlatform.system}
      );
      pkgsExtended = pkgs.extend self.overlays.default;
      overriddenPkgs = lib.map (p: lib.getAttrFromPath p.name pkgsExtended) pkgList;
      flakePkgs = lib.map (p: p.value) pkgList;
    in
    overriddenPkgs ++ flakePkgs;
}
