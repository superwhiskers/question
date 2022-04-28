{ pkgs
, stdenv
, elixir
, makeWrapper
, ...
}:
pkgs.stdenv.mkDerivation rec {
  name = "question-elixir";

  src = builtins.path {
    path = ../../elixir;
    name = name;
  };

  buildInputs = [ elixir makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    cp ./question.ex $out/bin/${name}.ex
    makeWrapper ${elixir}/bin/elixir $out/bin/${name} --add-flags $out/bin/${name}.ex
  '';
}
