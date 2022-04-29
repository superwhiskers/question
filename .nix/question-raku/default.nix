{ self
, stdenv
, makeWrapper
, rakudo
, ...
}:

stdenv.mkDerivation rec {
  name = "question-raku";

  src = builtins.path {
    path = ../../raku;
    name = name;
  };

  buildInputs = [
    rakudo
    makeWrapper
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp ./question.raku $out/bin/$name.raku
    makeWrapper ${rakudo}/bin/rakudo $out/bin/$name --add-flags $out/bin/$name.raku

    runHook postInstall
  '';
}
