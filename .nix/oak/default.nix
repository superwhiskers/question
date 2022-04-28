{ self
, buildGoModule
, fetchFromGitHub
, ...
}:

buildGoModule rec {
  pname = "oak";
  version = "0.2";

  src = fetchFromGitHub {
    owner = "thesephist";
    repo = "oak";
    rev = "v${version}";
    hash = "sha256-Tr/3PlV+tZCZQNFUB8Kk2LU5uoGyQmmgV3eB8YNR/8o=";
  };

  vendorSha256 = "sha256-iQtb3zNa57nB6x4InVPw7FCmW7XPw5yuz0OcfASXPD8=";

  ldflags = [ "-s" "-w" ];
}
