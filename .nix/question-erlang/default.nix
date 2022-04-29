{ stdenv, erlang, makeWrapper, ... }:
stdenv.mkDerivation rec {
  name = "question-erlang";

  src = builtins.path {
    path = ../../erlang;
    name = name;
  };

  buildInputs = [ erlang makeWrapper ];

  buildPhase = ''
    runHook preBuild

    erlc question.erl

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mv ./question.beam $out/bin/$name.beam
    makeWrapper ${erlang}/bin/escript $out/bin/$name --add-flags $out/bin/$name.beam

    runHook postInstall
  '';
}
