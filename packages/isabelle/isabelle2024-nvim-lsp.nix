{ isabelle
, fetchFromGitHub
}:

isabelle.overrideAttrs (final: prev:
  let
    src_dev = fetchFromGitHub {
      owner = "Treeniks";
      repo = "isabelle-language-server";
      rev = "5453ad2f677ba646096a66c22f0bad6ee0de9381";
      sha256 = "sha256-TgIo5Y1TFa0PPVv2QmBRCKFoYU3tjNNw+7MuN+vc+Zg=";
    };
  in {
    version = "2024-nvim-lsp";
    prePatch = ''
      rm -r src/
      cp -r ${src_dev}/src ./
      cp ${src_dev}/etc/build.props etc/
      chmod -R +w ./src
    '';
  }
)
