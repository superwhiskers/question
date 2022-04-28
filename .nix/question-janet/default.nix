{ self
, pkgs
, stdenv
, janet
, makeWrapper
, ...
}:

stdenv.mkDerivation rec {
  name = "question-janet";

  src = builtins.path {
    path = ../../janet;
    name = name;
  };

  buildInputs = [
    janet
    makeWrapper
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp ./question.janet $out/bin/$name.janet
    makeWrapper ${pkgs.janet}/bin/janet $out/bin/$name --add-flags $out/bin/$name.janet
  '';
}
