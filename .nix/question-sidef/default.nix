{ self
, stdenv
, sidef
, makeWrapper
, perlPackages
, ...
}:

stdenv.mkDerivation rec {
  name = "question-sidef";

  src = builtins.path {
    path = ../../sidef;
    name = name;
  };

  nativeBuildInputs = [
    sidef
    makeWrapper
  ];

  installPhase = ''
    runHook preInstall
                
    mkdir -p $out/bin
    mv ./question.sf $out/bin/$name.sf
    
    makeWrapper ${sidef}/bin/sidef $out/bin/$name \
      --add-flags $out/bin/$name.sf

    runHook postInstall
  '';
}
