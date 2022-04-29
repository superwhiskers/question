{ stdenv, crystal, ... }:

stdenv.mkDerivation rec {
  name = "question-crystal";

  src = builtins.path {
    path = ../../crystal;
    name = name;
  };

  nativeBuildInputs = [
    crystal
  ];

  buildPhase = ''
    runHook preBuild

    crystal build question.cr -o $name

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
      
    mkdir -p $out/bin
    mv $name $out/bin/$name

    runHook postInstall
  '';
}
