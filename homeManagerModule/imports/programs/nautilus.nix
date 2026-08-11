{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.nautilus;
in
{
  options.programs.nautilus = {
    enable = lib.mkEnableOption "Nautilus";
    package = lib.mkPackageOption pkgs "nautilus" { };
    extensions = lib.mkOption {
      default = [ ];
      example = lib.literalExpression ''
        [
          pkgs.nautilus-open-any-terminal
        ]
      '';
      type = lib.types.listOf lib.types.package;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
    dbus.packages = [ cfg.package ];

    home.sessionVariables.NAUTILUS_4_EXTENSION_DIR = lib.mkIf (
      cfg.extensions != [ ]
    ) "${pkgs.nautilus-python}/lib/nautilus/extensions-4";

    xdg.dataFile."nautilus-python/extensions" =
      let
        extMerged = pkgs.symlinkJoin {
          name = "nautilus-python-extensions";
          paths = cfg.extensions;
        };
      in
      lib.mkIf (cfg.extensions != [ ]) {
        source = "${extMerged}/share/nautilus-python/extensions";
        recursive = true;
      };
  };
}
