{ self
, stdenv
, oak
, makeWrapper
, ...
}:

stdenv.mkDerivation rec {
  name = "question-oak";

  src = builtins.path {
    path = ../../oak;
    name = name;
  };

  nativeBuildInputs = [
    oak
    makeWrapper
  ];

  buildPhase = ''
    runHook preBuild

    oak build --entry question.oak --output bundle.oak

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/bin
    mv ./bundle.oak $out/bin/$name.oak
    makeWrapper ${oak}/bin/oak $out/bin/$name --add-flags $out/bin/$name.oak
  
    runHook postInstall
  '';
}
