{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    utils.url = github:gytis-ivaskevicius/flake-utils-plus;
  };

  outputs = inputs@{ self, nixpkgs, utils }:
    let
      name = "question-crystal";
    in
    utils.lib.mkFlake {
      inherit self inputs;

      outputsBuilder = channels: rec {
        packages = {
          ${name} = channels.nixpkgs.stdenv.mkDerivation {
            name = name;

            src = builtins.path {
              path = ./.;
              name = name;
            };

            nativeBuildInputs = [
              channels.nixpkgs.crystal
            ];

            buildPhase = ''
              runHook preBuild

              crystal build question.cr -o question

              runHook postBuild
            '';

            installPhase = ''
              runHook preInstall
              
              mkdir -p $out/bin
              cp ./question $out/bin/${name}

              runHook postInstall
            '';
          };
        };

        defaultPackage = packages.${name};
        defaltApp = packages.${name};

        devShell = channels.nixpkgs.mkShell {
          name = "devshell";
          nativeBuildInputs = [ channels.nixpkgs.crystal ];
        };
      };
    };
}
