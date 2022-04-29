{ stdenv, odin, ... }:

stdenv.mkDerivation rec {
  name = "question-odin";

  src = builtins.path {
    path = ../../odin;
    name = name;
  };

  nativeBuildInputs = [
    odin
  ];

  buildPhase = ''
    runHook preBuild

    odin build question.odin -out:question

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
              
    mkdir -p $out/bin
    mv ./question $out/bin/$name

    runHook postInstall
  '';
}
