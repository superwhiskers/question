{ self
, lib
, rustPlatform
, fetchFromGitHub
, ...
}:

rustPlatform.buildRustPackage rec {
  pname = "oakc";
  version = "604f06ebfa4138c58f87461103d0b8ae1c0f87bf";

  src = fetchFromGitHub {
    owner = "adam-mcdaniel";
    repo = pname;
    rev = version;
    sha256 = "sha256-fQiDz+kMKf5HmCv21ajRhMH9hJuGE5R3RMuLwbSLaV4=";
  };

  cargoSha256 = "sha256-RzhMST6oi34CBtDNJ32cIqXJ2lXGEcKgAwKahBS1dZo=";

  meta = with lib; {
    description = "A portable programming language with a compact intermediate representation";
    homepage = "https://github.com/adam-mcdaniel/oakc";
    license = licenses.asl20;
  };
}