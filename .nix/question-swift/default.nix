{ stdenv, swift, ... }:

stdenv.mkDerivation rec {
  name = "question-swift";

  src = builtins.path {
    path = ../../swift;
    name = name;
  };

  nativeBuildInputs = [
    swift
  ];

  buildPhase = ''
    runHook preBuild

    swiftc -o $name question.swift

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp $name $out/bin/$name

    runHook postInstall
  '';
}
