_: _:

{
  callPackage,
  callPackages,
  fetchurl,
  lib,
  stdenv,
}:

let
  # from https://git.sr.ht/~rycee/nur-expressions/tree/18a6dab66b23ad2b9a51048c0d3d9605b2343659/item/lib/mozilla.nix
  buildMozillaXpiAddon = lib.makeOverridable (
    {
      pname,
      version,
      addonId,
      url,
      sha256,
      meta,
      ...
    }:
    stdenv.mkDerivation {
      inherit pname version meta;

      src = fetchurl { inherit url sha256; };

      preferLocalBuild = true;
      allowSubstitutes = true;

      passthru = {
        inherit addonId;
      };

      buildCommand = ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir -p "$dst"
        install -v -m644 "$src" "$dst/${addonId}.xpi"
      '';
    }
  );
  addons-generated = lib.makeExtensible (
    _: callPackages ./addons-generated.nix { inherit buildMozillaXpiAddon; }
  );
in
addons-generated.extend (callPackage ./overrides.nix { })
