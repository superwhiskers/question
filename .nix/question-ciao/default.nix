{ self
, pkgs
, stdenv
, ciao
, ...
}:

stdenv.mkDerivation rec {
  name = "question-ciao";

  src = builtins.path {
    path = ../../ciao;
    name = self.name;
  };

  nativeBuildInputs = [ ciao ];

  buildPhase = ''
    runHook preBuild

    ciaoc -o $name question.pl

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/bin
    mv $name $out/bin/$name

    runHook postInstall
  '';
}