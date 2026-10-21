{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.nextcloud-sync;
in
{
  options.services.nextcloud-sync = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          package = lib.mkPackageOption pkgs "nextcloud-client" { };
          localPath = lib.mkOption {
            type = lib.types.path;
            description = "Local directory to sync with remote directory";
            example = "~/Documents/Sync";
          };
          remotePath = lib.mkOption {
            type = lib.types.path;
            description = "Remote directory to sync with local directory";
            example = "/Photos/Laptop";
            default = "/";
          };
          host = lib.mkOption {
            type = lib.types.str;
            description = "The URL where the nextcloud instance is accessible";
            example = "https://nextcloud.example.com";
          };
          extraArgs = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            description = "Extra arguments to append to nextcloudcmd";
            default = [ ];
            example = lib.literalExpression ''
              [
                "--trust"
              ]
            '';
          };
          environmentFiles = lib.mkOption {
            type = lib.types.listOf lib.types.path;
            description = "Environment files to source before executing nextcloudcmd";
            default = [ ];
            example = lib.literalExpression ''
              [
                "~/.config/secrets/nextcloud-password.env"
              ];
            '';
          };
          timerConfig = lib.mkOption {
            type = lib.types.attrs;
            default = {
              OnCalendar = "daily";
              Persistent = true;
            };
            description = ''
              When to run the backup. See {manpage}`systemd.timer(5)` for
              details. If null no timer is created and the backup will only
              run when explicitly started.
            '';
            example = {
              OnCalendar = "00:05";
              RandomizedDelaySec = "5h";
              Persistent = true;
            };
          };
        };
      }
    );
  };

  config = {
    systemd.user = {
      services = lib.mapAttrs' (
        name:
        {
          environmentFiles,
          extraArgs,
          host,
          localPath,
          package,
          remotePath,
          ...
        }:
        lib.nameValuePair "nextcloud-sync-${name}" {
          Service = {
            EnvironmentFile = environmentFiles;
            ExecStart = lib.escapeShellArgs (
              [
                (lib.getExe' package "nextcloudcmd")
                "--non-interactive"
                "--path"
                remotePath
              ]
              ++ extraArgs
              ++ [
                localPath
                host
              ]
            );
            Type = "oneshot";

          };
        }
      ) cfg;
      timers = lib.mapAttrs' (
        name:
        {
          timerConfig,
          ...
        }:
        lib.nameValuePair "nextcloud-sync-${name}" (
          lib.mkIf (timerConfig != null) {
            Install.WantedBy = [ "timers.target" ];
            Timer = timerConfig;
          }
        )
      ) cfg;
      tmpfiles.rules = lib.mapAttrsToList (
        _:
        {
          localPath,
          ...
        }:
        "d ${lib.escapeShellArg localPath}"
      ) cfg;
    };
  };
}
