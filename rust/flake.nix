{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    utils.url = github:gytis-ivaskevicius/flake-utils-plus;
  };

  outputs = inputs@{ self, nixpkgs, utils }:
    let
      name = "question-rust";
    in
    utils.lib.mkFlake {
      inherit self inputs;

      outputsBuilder = channels: {
        defaultPackage = channels.nixpkgs.stdenv.mkDerivation {
          name = name;

          src = builtins.path {
            path = ./.;
            name = name;
          };

          nativeBuildInputs = [
            channels.nixpkgs.rustup
          ];

          preBuild = ''
            export HOME=$TMPDIR
          '';

          buildPhase = ''
            runHook preBuild

            cargo build --release
          '';

          installPhase = ''            
            mkdir -p $out/bin
            cp ./target/release/question $out/bin/${name}
          '';
        };

        devShell = channels.nixpkgs.mkShell {
          name = "devshell";
          nativeBuildInputs = with channels.nixpkgs; [ rustup ];
        };
      };
    };
}
