{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    utils.url = github:gytis-ivaskevicius/flake-utils-plus;
  };

  outputs = inputs@{ self, nixpkgs, utils, fenix }:
    utils.lib.mkFlake {
      inherit self inputs;

      outputsBuilder = channels:
        let
          name = "question-oak";
          pkgs = channels.nixpkgs;
          inherit(pkgs) lib fetchFromGitHub rustPlatform;
        in
        rec {
          packages = {
            oakc = rustPlatform.buildRustPackage rec {
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
            };

            ${name} = channels.nixpkgs.stdenv.mkDerivation {
              name = name;

              src = builtins.path {
                path = ./.;
                name = name;
              };

              nativeBuildInputs = [
                packages.oakc
              ];

              buildPhase = ''
                runHook preBuild

                oak c question.ok

                runHook postBuild
              '';

              installPhase = ''
                runHook preInstall
                
                mkdir -p $out/bin
                cp ./main $out/bin/${name}

                runHook postInstall
              '';
            };
          };

          apps = {
            oakc = utils.lib.mkApp {
              name = "oak";
              drv = packages.oak;
            };
            ${name} = packages.${name};
          };

          defaultApp = packages.${name};

          devShell = pkgs.mkShell {
            name = "devshell";
            nativeBuildInputs = [ packages.oakc ];
          };
        };
    };
}
