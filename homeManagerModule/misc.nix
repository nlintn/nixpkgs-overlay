{ config, lib, ... }:

{
  options = {
    systemd.user.loginctlPath = lib.mkOption {
      default = "${builtins.dirOf config.systemd.user.systemctlPath}/loginctl";
      defaultText = lib.literalExpression ''"''${builtins.dirOf config.systemd.user.systemctlPath}/loginctl"'';
      type = lib.types.str;
      description = ''
        Absolute path to the {command}`loginctl` tool. This
        option may need to be set if running Home Manager on a
        non-NixOS distribution.
      '';
    };
  };
}
