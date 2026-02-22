{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.wayland-pipewire-idle-inhibit;
in
{
  options.services.wayland-pipewire-idle-inhibit = {
    enable = lib.mkEnableOption "Wayland PipeWire Idle Inhibit";
    package = lib.mkPackageOption pkgs "wayland-pipewire-idle-inhibit" { };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.wayland-pipewire-idle-inhibit = {
      Unit = {
        Description = "Inhibit Wayland idling when media is played through pipewire";
      };
      Install.WantedBy = [ "graphical-session.target" ];
      Service = {
        ExecStart = "${cfg.package}/bin/wayland-pipewire-idle-inhibit";
        Restart = "on-failure";
        RestartSec = 10;
      };
    };
  };
}
