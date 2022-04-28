{ pkgs
, stdenv
, erlang
, makeWrapper
, ...
}:
stdenv.mkDerivation rec {
  name = "question-erlang";

  src = builtins.path {
    path = ../../erlang;
    name = name;
  };

  buildInputs = [ erlang makeWrapper ];

  buildPhase = ''
    erlc question.erl
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp ./question.beam $out/bin/${name}.beam
    makeWrapper ${erlang}/bin/escript $out/bin/${name} --add-flags $out/bin/${name}.beam
  '';
}
