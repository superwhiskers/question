{ stdenv, uxn, makeWrapper, ... }:

stdenv.mkDerivation rec {
  name = "question-uxn";

  src = builtins.path {
    path = ../../uxn;
    name = name;
  };

  nativeBuildInputs = [
    uxn
    makeWrapper
  ];

  buildPhase = ''
    runHook preBuild

    uxnasm main.tal question.rom

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
                
    mkdir -p $out/share/uxn
    cp ./question.rom $out/share/uxn/$name.rom
    makeWrapper ${uxn}/bin/uxncli $out/bin/$name --add-flags $out/share/uxn/$name.rom

    runHook postInstall
  '';
}
        