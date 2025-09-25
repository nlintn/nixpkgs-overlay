pkgs: self:

pkgs.symlinkJoin {
  name = "check-build";
  paths = builtins.filter pkgs.lib.isDerivation (self.lib.attrsToListRecursive self.legacyPackages.${pkgs.system});
}
