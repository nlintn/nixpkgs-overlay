{ config, lib, pkgs, ... }:

let
  cfg = config.services.protonmail-bridge;
in {
  options.services.protonmail-bridge = {
    enable = lib.mkEnableOption "ProtonMail Bridge";
    package = lib.mkPackageOption pkgs "protonmail-bridge" { };
    logLevel = lib.mkOption {
      default = null;
      description = "Log level of the ProtonMail Bridge service. If set to null then the service uses it's default log level.";
      type = lib.types.nullOr (
        lib.types.enum [
          "panic"
          "fatal"
          "error"
          "warn"
          "info"
          "debug"
        ]
      );
    };
  };

  config = let
    unitName = "protonmail-bridge";
    cfgScript = pkgs.writeScriptBin "protonmail-bridge-cfg" /* sh */ ''
      function restart-bridge() {
        ${config.systemd.user.systemctlPath} --user restart ${unitName}.service
      }
      builtin trap -- "restart-bridge;exit" \
          SIGABRT SIGALRM SIGBUS SIGFPE SIGHUP SIGILL SIGINT SIGIO \
          SIGPIPE SIGPOLL SIGPROF SIGPWR SIGQUIT SIGSEGV SIGSYS \
          SIGTERM SIGTRAP SIGUSR1 SIGUSR2 SIGVTALRM SIGXCPU SIGXFSZ &&
      ${config.systemd.user.systemctlPath} --user stop ${unitName}.service &&
      ${cfg.package}/bin/protonmail-bridge --cli;
      restart-bridge
    '';
  in lib.mkIf cfg.enable {
    home.packages = [ cfgScript ];

    systemd.user.services.${unitName} = {
      Unit = {
        After = [ "graphical-session.target" ];
        Description = "ProtonMail Bridge";
      };
      Install.WantedBy = [ "graphical-session.target" ];

      Service = let
        logLevel = lib.optionalString (cfg.logLevel != null) "--log-level ${cfg.logLevel}";
      in {
        ExecStart = "${cfg.package}/bin/protonmail-bridge -n ${logLevel}";
        Restart = "always";
      };
    };
  };
}
