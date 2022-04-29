{ stdenv, python3, makeWrapper, ... }:

stdenv.mkDerivation rec {
  name = "question-python";

  src = builtins.path {
    path = ../../python;
    name = name;
  };

  buildInputs = [
    python3
    makeWrapper
  ];

  installPhase = ''
    mkdir -p $out/bin
    mv ./question.py $out/bin/$name.py
    makeWrapper ${python3}/bin/python $out/bin/$name --add-flags $out/bin/$name.py
  '';
}
