{ config, lib, pkgs, ... }:

let
  cfg = config.programs.nm-applet;
in {
  options.programs.nm-applet = {
    enable = lib.mkEnableOption "nm-applet";
    package = lib.mkPackageOption pkgs "networkmanagerapplet" { };
    indicator = lib.mkOption {
      default = true;
      description = "pass --indicator to nm-applet";
      example = false;
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
    dbus.packages = [ pkgs.gcr ];

    systemd.user.services.nm-applet = {
      Unit = {
        Description = "NetworkManager applet";
        Documentation = "man:nm-applet(1)";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Install.WantedBy = [ "graphical-session.target" ];
      Service = {
        ExecStart = "${cfg.package}/bin/nm-applet ${lib.optionalString cfg.indicator "--indicator"}";
      };
    };
  };
}
