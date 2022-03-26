{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, utils, fenix }:
    utils.lib.eachDefaultSystem (system:
      let
        name = "question-dyon";
        pkgs = nixpkgs.legacyPackages.${system};
        inherit (pkgs) lib fetchCrate makeRustPlatform;
        rustPlatform = makeRustPlatform { inherit (fenix.packages.${system}.minimal) cargo rustc; };
      in rec {

        packages = {
          dyon = rustPlatform.buildRustPackage rec {
            pname = "dyon";
            version = "0.47.3";

            src = fetchCrate {
              inherit pname version;
              sha256 = "sha256-hShe8Mj8lEuyXwaOz5lraSA+AEQUx6BknIR/WezTxOQ=";
            };
            cargoHash = "sha256-8tG4dnmb5kzX6JTWDPkbltxlxzCFxXP8G6K6PGDCVxQ=";

            dontCargoCheck = true;

            buildPhase = ''
              cargo build --example dyonrun --release        
            '';

            installPhase = ''
              mkdir -p $out/bin
              cp ./target/release/examples/dyonrun $out/bin
            '';

            meta = with lib; {
              description = "A rusty dynamically typed scripting language";
              homepage = "https://github.com/PistonDevelopers/dyon";
              license = licenses.asl20;
            };
          };

          ${name} = pkgs.stdenv.mkDerivation {
            name = name;

            src = builtins.path {
              path = ./.;
              name = name;
            };

            nativeBuildInputs = [
              packages.dyon
              pkgs.makeWrapper
            ];

            installPhase = ''
              runHook preInstall
            
              mkdir -p $out/bin
              cp ./question.dyon $out/bin/${name}.dyon
              makeWrapper ${packages.dyon}/bin/dyonrun $out/bin/${name} --add-flags $out/bin/${name}.dyon
              
              runHook postInstall
            '';
          };
        };

        apps = {
          ${name} = packages.${name};
        };

        defaultApp = packages.${name};

        devShell = pkgs.mkShell {
          name = "devshell";
          nativeBuildInputs = [ packages.dyon ];
        };
      });
}
