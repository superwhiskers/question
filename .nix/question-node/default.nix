{ self
, pkgs
, stdenv
, nodejs-17_x
, makeWrapper
, ...
}:

stdenv.mkDerivation rec {
  name = "question-node";

  src = builtins.path {
    path = ../../js/node;
    name = name;
  };

  buildInputs = [
    nodejs-17_x
    makeWrapper
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp package.json $out/bin/package.json
    cp ./question.js $out/bin/$name.js
    makeWrapper ${pkgs.nodejs-17_x}/bin/node $out/bin/$name --add-flags $out/bin/$name.js

    runHook postInstall
  '';
}
