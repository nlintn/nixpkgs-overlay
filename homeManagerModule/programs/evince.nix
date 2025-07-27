{ config, lib, pkgs, ... }:

let
  cfg = config.programs.evince;
in {
  options.programs.evince = {
    enable = lib.mkEnableOption "Evince";
    package = lib.mkPackageOption pkgs "evince" { };
    daemon.enable = lib.mkOption {
      default = true;
      example = false;
      description = "Wether to enable Evince daemon";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
    dbus.packages = [ cfg.package ];

    systemd.user.services."org.gnome.Evince" = lib.mkIf cfg.daemon.enable {
      Unit = {
        Description = "Evince document viewer";
        Documentation = "man:evince(1)";
      };
      Service = {
        Type = "dbus";
        BusName = "org.gnome.evince.Daemon";
        ExecStart = "${cfg.package}/libexec/evinced";
      };
    };
  };
}
