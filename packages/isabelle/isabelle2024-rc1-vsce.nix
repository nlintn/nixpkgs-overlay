{ isabelle2024-rc1
, fetchFromGitHub
}:

isabelle2024-rc1.overrideAttrs (final: prev:
  let
    src_dev = fetchFromGitHub {
      owner = "m-fleury";
      repo = "isabelle-emacs";
      rev = "0a64e6de0e8aae7190f8ec4506d275b356a85f8e";
      sha256 = "sha256-JyidfRAMIdXfwe/y7wKi1NBMfQ/+5C29/Netxwj2lb4=";
    };
  in rec {
    version = "2024-RC1-vsce";
    applyNvimLspPatch = false;
    prePatch = ''
      rm -r src/
      cp -r ${src_dev}/src ./
      cp ${src_dev}/etc/build.props etc/
      chmod -R +w ./src
    '';
    patches = prev.patches or [] ++ ( if applyNvimLspPatch then [ ./isabelle-nvim-lsp-fix.patch ] else [] );
  }
)
