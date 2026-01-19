pkgs: self:

pkgs.symlinkJoin {
  name = "check-build";
  paths = pkgs.lib.filter pkgs.lib.isDerivation (
    self.lib.attrsToListRecursive self.legacyPackages.${pkgs.stdenv.hostPlatform.system}
  );
}
