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
 in {
   version = "2023-vsce";
   prePatch = ''
     rm -r src/
     cp -r ${src_dev}/src ./
     cp ${src_dev}/etc/build.props etc/
     chmod -R +w ./src
   '';
  }
)
