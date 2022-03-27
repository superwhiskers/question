{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    utils.url = github:gytis-ivaskevicius/flake-utils-plus;
  };

  outputs = inputs@{ self, nixpkgs, utils }:
    utils.lib.mkFlake {
      inherit self inputs;

      outputsBuilder = channels:
        let
          name = "question-oak-thesphist";
          pkgs = channels.nixpkgs;
        in
        rec {
          packages = {
            oak =
              let
                rev = "v0.2";
              in
              pkgs.buildGoModule {
                pname = "oak";
                version = rev;
                src = pkgs.fetchFromGitHub {
                  owner = "thesephist";
                  repo = "oak";
                  rev = rev;
                  hash = "sha256-Tr/3PlV+tZCZQNFUB8Kk2LU5uoGyQmmgV3eB8YNR/8o=";
                };

                vendorSha256 = "sha256-iQtb3zNa57nB6x4InVPw7FCmW7XPw5yuz0OcfASXPD8=";

                ldflags = [ "-s" "-w" ];
              };

              ${name} = pkgs.stdenv.mkDerivation {
                name = name;

                src = builtins.path {
                  path = ./.;
                  name = name;
                };

                nativeBuildInputs = [
                  packages.oak
                  pkgs.makeWrapper
                ];

                buildPhase = ''
                  runHook preBuild

                  oak build --entry question.oak --output bundle.oak

                  runHook postBuild
                '';

                installPhase = ''
                  runHook preInstall
                  
                  mkdir -p $out/bin
                  cp ./bundle.oak $out/bin/${name}.oak
                  makeWrapper ${packages.oak}/bin/oak $out/bin/${name} --add-flags $out/bin/${name}.oak
                
                  runHook postInstall
                '';
              };
          };

          apps = {
            oak = utils.lib.mkApp {
              name = "oak";
              drv = packages.oak;
            };
            ${name} = packages.${name};
          };

          defaultApp = packages.${name};
          defaultPackage = packages.${name};

          devShell = pkgs.mkShell {
            name = "devshell";
            nativeBuildInputs = [ packages.oak ];
          };
        };
    };
}
