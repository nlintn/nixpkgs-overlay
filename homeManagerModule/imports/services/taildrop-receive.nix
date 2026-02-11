{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.taildrop-receive;
in
{
  options.services.taildrop-receive = {
    enable = lib.mkEnableOption "continuously move files out of the Tailscale inbox";
    package = lib.mkPackageOption pkgs "tailscale" { };
    directory = lib.mkOption {
      type = lib.types.path;
      default = "${config.home.homeDirectory}/taildrop";
      defaultText = lib.literalExpression ''
        "${config.home.homeDirectory}/taildrop"
      '';
      description = "Directory to save the files to";
      apply = lib.escapeShellArg;
    };
    conflict = lib.mkOption {
      default = "skip";
      description = "behavior when a conflicting (same-named) file already exists in the directory";
      type = lib.types.enum [
        "skip"
        "overwrite"
        "rename"
      ];
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.tmpfiles.rules = [
      "d  ${cfg.directory}  0700  -  -  -  -"
    ];
    systemd.user.services.taildrop-receive = {
      Unit = {
        Description = "Continuously move files out of the Tailscale inbox";
      };
      Install.WantedBy = [ "default.target" ];
      Service = {
        ExecStart = "${lib.escapeShellArg (lib.getExe cfg.package)} file get --loop --verbose --conflict=${cfg.conflict} ${cfg.directory}";
        Restart = "on-failure";
        RestartSec = 10;
      };
    };
  };
}
