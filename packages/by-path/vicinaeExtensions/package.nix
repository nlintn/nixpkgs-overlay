fetchSources: _:

{
  lib,
  mkVicinaeExtension,
}:

let
  extensions = fetchSources "https://github.com/vicinaehq/extensions";
in
lib.pipe (builtins.readDir "${extensions}/extensions") [
  (lib.filterAttrs (_name: type: type == "directory"))
  (lib.mapAttrs (
    name: _type:
    mkVicinaeExtension {
      pname = name;
      src = "${extensions}/extensions/${name}";
    }
  ))
  (lib.flip lib.removeAttrs [
    # TODO: fails to build due to node-gyp
    "dbus"
    "pass"
    "systemd"
  ])
]
