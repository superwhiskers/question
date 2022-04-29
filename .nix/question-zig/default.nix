{ stdenv, zig, ... }:

stdenv.mkDerivation rec {
  name = "question-zig";

  src = builtins.path {
    path = ../../zig;
    name = name;
  };

  nativeBuildInputs = [
    zig
  ];

  buildPhase = ''
    HOME=$TMPDIR
            
    runHook preBuild

    zig build-exe -Drelease-safe -Dcpu=baseline ./question.zig

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mv ./question $out/bin/$name
            
    runHook postInstall
  '';
}
