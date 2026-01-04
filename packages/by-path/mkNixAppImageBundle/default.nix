fetchSources:
_:

{ stdenv
}:

let
  src = fetchSources "https://github.com/ralismark/nix-appimage";
in (import src).bundlers.${stdenv.hostPlatform.system}.default
