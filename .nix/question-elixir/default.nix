{ stdenv, elixir, makeWrapper, ... }:
stdenv.mkDerivation rec {
  name = "question-elixir";

  src = builtins.path {
    path = ../../elixir;
    name = name;
  };

  buildInputs = [ elixir makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mv ./question.ex $out/bin/$name.ex
    makeWrapper ${elixir}/bin/elixir $out/bin/$name --add-flags $out/bin/$name.ex

    runHook postInstall
  '';
}
