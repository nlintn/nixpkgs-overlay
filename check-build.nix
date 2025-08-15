pkgs: self:

pkgs.symlinkJoin {
  name = "check-build";
  paths = self.lib.attrsToListRecursive self.legacyPackages.${pkgs.system};
}
