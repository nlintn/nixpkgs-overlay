{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.protonmail-bridge;
in
{
  options.services.protonmail-bridge = {
    enableCfgScript = lib.mkEnableOption "ProtonMail Bridge config script";
  };

  config =
    let
      unitName = "protonmail-bridge";
      cfgScript = pkgs.writeScriptBin "protonmail-bridge-cfg" /* sh */ ''
        function restart-bridge() {
          ${config.systemd.user.systemctlPath} --user restart ${unitName}.service
        }
        builtin trap -- "restart-bridge;exit" \
            SIGABRT SIGALRM SIGBUS SIGFPE SIGHUP SIGILL SIGINT SIGIO \
            SIGPIPE SIGIO SIGPROF SIGPWR SIGQUIT SIGSEGV SIGSYS \
            SIGTERM SIGTRAP SIGUSR1 SIGUSR2 SIGVTALRM SIGXCPU SIGXFSZ &&
        ${config.systemd.user.systemctlPath} --user stop ${unitName}.service &&
        ${cfg.package}/bin/protonmail-bridge --cli;
        restart-bridge
      '';
    in
    lib.mkIf (cfg.enable && cfg.enableCfgScript) {
      home.packages = [ cfgScript ];
    };
}
