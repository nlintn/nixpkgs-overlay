{ isabelle
, fetchFromGitHub
}:

isabelle.overrideAttrs (final: prev:
 let
   src_dev = fetchFromGitHub {
     owner = "m-fleury";
     repo = "isabelle-emacs";
     rev = "bd8fd356fbd373ff9e78cea09a58ba6de1d6ccfc";
     sha256 = "sha256-97x+BjFU3+QIAzqiCWArxb21FzdCDjK7TjZr191yX9k=";
   };
 in rec {
   version = "2023-vsce";
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
