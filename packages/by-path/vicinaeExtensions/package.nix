# code from https://github.com/vicinaehq/extensions/blob/90c5e6f208bca1b08543a1a09d76b60ddd30d0fe/flake.nix

fetchSources: _:

{
  lib,
  mkVicinaeExtension,
  stdenv,
}:

let
  extensions = fetchSources "https://github.com/vicinaehq/extensions";
in
lib.pipe (builtins.readDir "${extensions}/extensions") [
  (lib.filterAttrs (_name: type: type == "directory"))
  (lib.mapAttrs (
    name: _type:
    mkVicinaeExtension {
      inherit name;
      version = "unstable";
      src = stdenv.mkDerivation {
        name = "${name}-patched-tsconfig";
        src = "${extensions}/extensions/${name}";
        buildPhase = ''
          substituteInPlace tsconfig.json --replace "../../" "${extensions}/"
        '';
        installPhase = ''
          mkdir -p $out
          cp -r . $out
        '';
      };
    }
  ))
  (lib.flip lib.removeAttrs [
    # TODO: fails to build due to node-gyp
    "dbus"
    "pass"
    "systemd"
  ])
]
