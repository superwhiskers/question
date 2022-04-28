{ pkgs
, stdenv
, go
, ...
}:
stdenv.mkDerivation rec {
  name = "question-go";

  src = builtins.path {
    path = ../../go;
    name = name;
  };

  nativeBuildInputs = [ go ];

  buildPhase = ''
    runHook preBuild

    go build question.go

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/bin
    mv ./question $out/bin/${name}

    runHook postInstall
  '';
}
