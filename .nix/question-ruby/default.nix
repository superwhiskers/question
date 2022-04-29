{ stdenv, makeWrapper, ruby, ... }:

stdenv.mkDerivation rec {
  name = "question-ruby";

  src = builtins.path {
    path = ../../ruby;
    name = name;
  };

  buildInputs = [
    ruby
    makeWrapper
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mv ./question.rb $out/bin/$name.rb
    makeWrapper ${ruby}/bin/ruby $out/bin/$name --add-flags $out/bin/$name.rb

    runHook postInstall
  '';
}
