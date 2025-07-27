fetchSources:

{ stdenv
}:

stdenv.mkDerivation {
  name = "gdb-ptrfind";
  src = (fetchSources "https://github.com/ChaChaNop-Slide/ptrfind");
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p $out
    cp $src/ptrfind.py $out/
  '';
}
