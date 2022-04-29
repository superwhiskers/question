{ stdenv, lua, makeWrapper, ... }:

stdenv.mkDerivation rec {
  name = "question-lua";

  src = builtins.path {
    path = ../../lua;
    name = name;
  };

  buildInputs = [
    lua
    makeWrapper
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp ./question.lua $out/bin/$name.lua
    makeWrapper ${lua}/bin/lua $out/bin/$name --add-flags $out/bin/$name.lua

    runHook postInstall
  '';
}
