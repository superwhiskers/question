{ self
, pkgs
, lib
, stdenv
, callPackage
, perl534Packages
, perlPackages
, fetchurl
, extraPerlPackages ? callPackage ./perl-packages.nix pkgs
, ...
}:

let
  sidefPerlPackages = perl534Packages // extraPerlPackages;
in
perlPackages.buildPerlPackage rec {
  pname = "sidef";
  version = "3.99";

  src = fetchurl {
    url = "mirror://cpan/authors/id/T/TR/TRIZEN/Sidef-3.99.tar.gz";
    sha256 = "2a0559af90db43977a05507ab87b8c015e289dd635f2400d5f4cdf493d7a36ed";
  };

  propagatedBuildInputs = with sidefPerlPackages; [
    AlgorithmCombinatorics
    AlgorithmLoops
    DataDump
    MathGMPq
    MathGMPz
    MathMPC
    MathMPFR
    MathPrimeUtilGMP
  ];

  postInstall = lib.optionalString stdenv.isDarwin ''
    shortenPerlShebang $out/bin/sidef
  '';

  meta = {
    homepage = "https://github.com/trizen/sidef";
    description = "The Sidef Programming Language";
    license = lib.licenses.artistic2;
    mainProgram = "sidef";
  };
}
