{ self
, nimPackages
, ...
}:

nimPackages.buildNimPackage rec {
  name = "question-nim";
  nimBinOnly = true;

  src = builtins.path {
    path = ../../nim;
    name = name;
  };

  postFixup = ''
    mv $out/bin/question $out/bin/$name
  '';
}
