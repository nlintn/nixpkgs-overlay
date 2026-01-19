{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.thunar;
in
{
  options.programs.thunar = {
    enable = lib.mkEnableOption "Thunar";
    package = lib.mkPackageOption pkgs "thunar" { };
    finalPackage = lib.mkOption {
      description = "The wrapped thunar package";
      readOnly = true;
      type = lib.types.package;
    };
    plugins = lib.mkOption {
      default = [ ];
      example = [
        pkgs.xfce.thunar-archive-plugin
        pkgs.xfce.thunar-media-tags-plugin
      ];
      type = lib.types.listOf lib.types.package;
    };
    daemon.enable = lib.mkOption {
      default = true;
      example = false;
      description = "Wether to enable Thunar daemon";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable (
    let
      pkg = cfg.package.override { thunarPlugins = cfg.plugins; };
    in
    {
      home.packages = [ pkg ];
      dbus.packages = [ pkg ];

      systemd.user.services.thunar = lib.mkIf cfg.daemon.enable {
        Unit = {
          Description = "Thunar file manager";
          Documentation = "man:Thunar(1)";
        };
        Service = {
          Type = "dbus";
          ExecStart = "${pkg}/bin/Thunar --daemon";
          BusName = "org.xfce.FileManager";
          KillMode = "process";
        };
      };
      programs.thunar.finalPackage = pkg;
    }
  );
}
