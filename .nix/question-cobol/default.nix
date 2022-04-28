{ pkgs
, stdenv
, gnu-cobol
, ...
}:

stdenv.mkDerivation rec {
  name = "question-cobol";

  src = builtins.path {
    path = ../../cobol;
    name = name;
  };

  nativeBuildInputs = [ gnu-cobol ];

  buildPhase = ''
    runHook preBuild

    cobc -x question.cob -o $name

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/bin
    mv $name $out/bin/$name

    runHook postInstall
  '';
}
