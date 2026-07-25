fetchSources: _:

{
  lib,
  mkVicinaeExtension,
  pkgs,
  stdenv,
}:

let
  extensionsFlake = src: "${fetchSources src}/flake.nix";
  system = stdenv.hostPlatform.system;
  systems = lib.toFile "systems.nix" "[${(lib.concatStringsSep " " (lib.map lib.toJSON lib.systems.flakeExposed))}]";
  flakeArgs = self: {
    inherit self systems;
    nixpkgs.legacyPackages.${system} = pkgs;
    nixpkgs.lib = lib;
    vicinae.lib.${system}.mkVicinaeExtension = mkVicinaeExtension;
    vicinae.packages.${system}.mkVicinaeExtension = mkVicinaeExtension;
  };
  vicinaeExtensions =
    src: (lib.fix (self: (import (extensionsFlake src)).outputs (flakeArgs self))).packages.${system};

  extensions = vicinaeExtensions "https://github.com/vicinaehq/extensions";
  extensionsLockedBluetooth = vicinaeExtensions "https://github.com/vicinaehq/extensions_locked_bluetooth";
in
extensions
// {
  bluetooth = extensions.bluetooth or extensionsLockedBluetooth.bluetooth;
}
