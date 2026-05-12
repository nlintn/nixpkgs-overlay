# code from https://github.com/vicinaehq/extensions/blob/a8bd5e41709e32599cbb74961bbd7ee13106e6ec/flake.nix

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
      pname = "vicinae-extension-${name}";
      version = "unstable";
      src = "${extensions}/extensions/${name}";
      postPatch = ''
        substituteInPlace tsconfig.json --replace "../../" "${extensions}/"
      '';
    }
  ))
  (lib.flip lib.removeAttrs [
    # TODO: fails to build due to node-gyp
    "dbus"
    "pass"
    "systemd"
  ])
]
