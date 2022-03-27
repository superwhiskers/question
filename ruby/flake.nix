{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    utils.url = github:gytis-ivaskevicius/flake-utils-plus;
  };

  outputs = inputs@{ self, nixpkgs, utils }:
    utils.lib.mkFlake {
      inherit self inputs;

      outputsBuilder = channels:
        let
          name = "question-ruby";
          pkgs = channels.nixpkgs;
        in
        rec {
          app.${name} = pkgs.stdenv.mkDerivation {
            name = name;

            src = builtins.path {
              path = ./.;
              name = name;
            };

            buildInputs = [
              pkgs.ruby
              pkgs.makeWrapper
            ];

            installPhase = ''
              mkdir -p $out/bin
              cp ./question.rb $out/bin/${name}.rb
              makeWrapper ${pkgs.ruby}/bin/ruby $out/bin/${name} --add-flags $out/bin/${name}.rb
            '';
          };

          defaultApp = app.${name};

          devShell = pkgs.mkShell {
            name = "devshell";
            nativeBuildInputs = [ pkgs.ruby ];
          };
        };
    };
}
