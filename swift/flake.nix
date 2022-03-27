{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    utils.url = github:gytis-ivaskevicius/flake-utils-plus;
  };

  outputs = inputs@{ self, nixpkgs, utils }:
    let
      name = "question-swift";
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
              channels.nixpkgs.swift
            ];

            buildPhase = ''
              runHook preBuild

              swiftc -o question question.swift

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
          nativeBuildInputs = [ channels.nixpkgs.swift ];
        };
      };
    };
}
