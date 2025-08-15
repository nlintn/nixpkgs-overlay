pkgs: self:

pkgs.symlinkJoin {
  name = "test";
  paths = self.lib.attrsToListRecursive self.legacyPackages.${pkgs.system};
}
