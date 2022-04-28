{ self
, pkgs
, stdenv
, myrddin
, ...
}:

stdenv.mkDerivation rec {
  name = "question-myrddin";

  src = builtins.path {
    path = ../../myrddin;
    name = name;
  };

  nativeBuildInputs = [
    myrddin
  ];

  buildPhase = ''
    runHook preBuild

    mbld -b $name question.myr

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
      
    mkdir -p $out/bin
    mv $name $out/bin/$name

    runHook postInstall
  '';
}
