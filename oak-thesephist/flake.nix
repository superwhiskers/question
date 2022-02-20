{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    utils.url = github:gytis-ivaskevicius/flake-utils-plus;
  };

  outputs = inputs@{ self, nixpkgs, utils }:
    utils.lib.mkFlake {
      inherit self inputs;

      outputsBuilder = channels:
        let pkgs = channels.nixpkgs; in rec {
          packages = {
            oak =
              let
                rev = "0edef240ed27c8f83e0a94bb27ca55a50c76c47c";
              in
              pkgs.buildGoModule {
                pname = "oak";
                version = rev;
                src = pkgs.fetchFromGitHub {
                  owner = "thesephist";
                  repo = "oak";
                  rev = rev;
                  hash = "sha256-B83nC5i6AawAeBfOwk57uFrHAQZStML0vsWePxiQlWg=";
                };

                vendorSha256 = "sha256-iQtb3zNa57nB6x4InVPw7FCmW7XPw5yuz0OcfASXPD8=";

                ldflags = [ "-s" "-w" ];
              };
          };

          defaultApp = let name = "question-oak-thesphist"; in pkgs.stdenv.mkDerivation {
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

          devShell = pkgs.mkShell {
            name = "devshell";
            nativeBuildInputs = [ packages.oak ];
          };
        };
    };
}
