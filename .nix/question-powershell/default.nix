{ self
, stdenv
, powershell
, makeWrapper
, ...
}:

stdenv.mkDerivation rec {
  name = "question-powershell";

  src = builtins.path {
    path = ../../powershell;
    name = name;
  };

  buildInputs = [
    powershell
    makeWrapper
  ];

  installPhase = ''
    mkdir -p $out/bin
    mv ./question.ps1 $out/bin/$name.ps1
    makeWrapper ${powershell}/bin/pwsh $out/bin/$name --add-flags $out/bin/$name.ps1
  '';
}
