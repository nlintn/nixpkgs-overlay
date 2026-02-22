{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.tumbler;
in
{
  options.services.tumbler = {
    enable = lib.mkEnableOption "Tumbler, A D-Bus thumbnailer service";
    package = lib.mkPackageOption pkgs "tumbler";
  };

  config = lib.mkIf cfg.enable {
    dbus.packages = [ cfg.package ];
    home.packages = [ cfg.package ];
  };
}
