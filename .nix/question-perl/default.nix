{ self
, stdenv
, perl
, makeWrapper
, ...
}:

stdenv.mkDerivation rec {
  name = "question-perl";

  src = builtins.path {
    path = ../../perl;
    name = name;
  };

  buildInputs = [
    perl
    makeWrapper
  ];

  installPhase = ''
    mkdir -p $out/bin
    mv ./question.pl $out/bin/$name.pl
    makeWrapper ${perl}/bin/perl $out/bin/$name --add-flags $out/bin/$name.pl
  '';
}
