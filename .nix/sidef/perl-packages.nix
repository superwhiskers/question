{ self
, pkgs
, lib
, fetchurl
, perlPackages
, ...
}:

let
  inherit (perlPackages) buildPerlPackage;
in
rec {
  AlgorithmCombinatorics = buildPerlPackage {
    pname = "Algorithm-Combinatorics";
    version = "0.27";
    src = fetchurl {
      url = "mirror://cpan/authors/id/F/FX/FXN/Algorithm-Combinatorics-0.27.tar.gz";
      sha256 = "8378da39ecdb37d5cc89cc130a3b1353fd75d56c7690905673473fe4c25cd132";
    };
    meta = {
      description = "Efficient generation of combinatorial sequences";
    };
  };

  AlgorithmLoops = buildPerlPackage {
    pname = "Algorithm-Loops";
    version = "1.032";
    src = fetchurl {
      url = "mirror://cpan/authors/id/T/TY/TYEMQ/Algorithm-Loops-1.032.tar.gz";
      sha256 = "437eebed042093b365c1a90c65e53bf9ca2859dd889a0ae845fe9f9da3c6c006";
    };
    meta = {
      license = lib.licenses.unfreeRedistributable;
    };
  };

  MathGMPq = buildPerlPackage {
    pname = "Math-GMPq";
    version = "0.51";
    src = fetchurl {
      url = "mirror://cpan/authors/id/S/SI/SISYPHUS/Math-GMPq-0.51.tar.gz";
      sha256 = "4ef7af29ffe63508642142be95336037bc4022fbac73ce98281e08f649c216ec";
    };
    buildInputs = [ pkgs.gmp ];
    NIX_CFLAGS_COMPILE = "-I${pkgs.gmp.dev}/include";
    NIX_CFLAGS_LINK = "-L${pkgs.gmp.out}/lib -lgmp";
    meta = {
      description = "Perl interface to the GMP rational functions";
      license = with lib.licenses; [ artistic1 gpl1Plus ];
    };
  };

  MathMPC = buildPerlPackage {
    pname = "Math-MPC";
    version = "1.15";
    src = fetchurl {
      url = "mirror://cpan/authors/id/S/SI/SISYPHUS/Math-MPC-1.15.tar.gz";
      sha256 = "b7b51ccb0cdb236be24219cac9b7d00d9c61b8fce5f1e9c02cf3d3992af0a5a6";
    };
    propagatedBuildInputs = [ MathMPFR ];
    buildInputs = [ pkgs.libmpc pkgs.gmp pkgs.mpfr ];
    NIX_CFLAGS_LINK = "-L${pkgs.libmpc.out}/lib -lmpc";
    meta = {
      description = "Perl interface to the MPC (multi precision complex) library";
      license = with lib.licenses; [ artistic1 gpl1Plus ];
    };
  };

  MathMPFR = buildPerlPackage {
    pname = "Math-MPFR";
    version = "4.21";
    src = fetchurl {
      url = "mirror://cpan/authors/id/S/SI/SISYPHUS/Math-MPFR-4.21.tar.gz";
      sha256 = "2959e17ba420702e74d521efa94d6bc77bca08ea4b18c4834aa7f2e52d9f7ebb";
    };
    buildInputs = [ pkgs.mpfr ];
    NIX_CFLAGS_COMPILE = "-I${pkgs.mpfr.dev}/include";
    NIX_CFLAGS_LINK = "-L${pkgs.mpfr.out}/lib -lmpfr";
    meta = {
      description = "Perl interface to the MPFR (floating point) library";
      license = with lib.licenses; [ artistic1 gpl1Plus ];
    };
  };
}
