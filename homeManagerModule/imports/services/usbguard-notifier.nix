{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.usbguard-notifier;
in
{
  options.services.usbguard-notifier = {
    enable = lib.mkEnableOption "USBGuard Notifier, A tool for detecting usbguard policy and device presence changes";
    package = lib.mkPackageOption pkgs "usbguard-notifier" { };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.usbguard-notifier = {
      Unit = {
        Description = "USBGuard Notifier";
      };
      Install.WantedBy = [ "default.target" ];
      Service.ExecStart = lib.getExe cfg.package;
    };
  };
}
