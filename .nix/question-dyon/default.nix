{ pkgs
, stdenv
, dyon
, makeWrapper
, ...
}:

stdenv.mkDerivation rec {
  name = "question-dyon";

  src = builtins.path {
    path = ../../dyon;
    name = name;
  };

  nativeBuildInputs = [ dyon makeWrapper ];

  installPhase = ''
    runHook preInstall
  
    mkdir -p $out/bin
    cp ./question.dyon $out/bin/${name}.dyon
    makeWrapper ${dyon}/bin/dyonrun $out/bin/${name} --add-flags $out/bin/${name}.dyon
    
    runHook postInstall
  '';
}
