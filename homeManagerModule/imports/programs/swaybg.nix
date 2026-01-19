{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.swaybg;
in
{
  options.programs.swaybg = {
    enable = lib.mkEnableOption "swaybg";
    package = lib.mkPackageOption pkgs "swaybg" { };
    image = {
      path = lib.mkOption {
        default = null;
        description = "image path for swaybg";
        example = "/home/$USER/Pictures/me.png";
        type = lib.types.nullOr lib.types.str;
      };
      mode = lib.mkOption {
        default = null;
        description = "mode to use for the image";
        example = "one of (stretch, fit, fill, center, tile, solid_color)";
        type = lib.types.nullOr (
          lib.types.enum [
            "stretch"
            "fit"
            "fill"
            "center"
            "tile"
            "solid_color"
          ]
        );
      };
    };
    color = lib.mkOption {
      default = null;
      description = "the background color (in RRGGBB format)";
      example = "4d3a27";
      type = lib.types.nullOr (
        lib.mkOptionType {
          name = "color";
          check =
            s:
            let
              hex_chars = [
                "1"
                "2"
                "3"
                "4"
                "5"
                "6"
                "7"
                "8"
                "9"
                "0"
                "a"
                "b"
                "c"
                "d"
                "e"
                "f"
              ];
              s' = lib.filter (x: x != "") (lib.splitString "" (lib.toLower s));
            in
            lib.types.str.check s && lib.length s' == 6 && lib.all (x: lib.any (y: x == y) hex_chars) s';
        }
      );
    };
  };
  config = lib.mkIf cfg.enable {
    systemd.user.services.swaybg =
      let
        imgPath = lib.optionalString (cfg.image.path != null) "-i ${cfg.image.path}";
        imgMode = lib.optionalString (cfg.image.mode != null) "-m ${cfg.image.mode}";
        color = lib.optionalString (cfg.color != null) "-c ${cfg.color}";
      in
      {
        Unit = {
          Description = "swaybg";
          Documentation = "man swaybg(1)";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
          ConditionEnvironment = "WAYLAND_DISPLAY";
        };
        Install.WantedBy = [ "graphical-session.target" ];
        Service = {
          ExecStart = "${cfg.package}/bin/swaybg ${color} ${imgPath} ${imgMode}";
          Restart = "on-failure";
        };
      };
  };
}
