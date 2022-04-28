{ self
, stdenv
, oakc
, ...
}:

stdenv.mkDerivation rec {
  name = "question-oakc";

  src = builtins.path {
    path = ../../oakc;
    name = name;
  };

  nativeBuildInputs = [
    oakc
  ];

  buildPhase = ''
    runHook preBuild

    oak c question.ok

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/bin
    cp ./main $out/bin/$name

    runHook postInstall
  '';
}