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
          name = "question-erlang";
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
              pkgs.erlang
              pkgs.makeWrapper
            ];

            buildPhase = ''
              erlc question.erl
            '';

            installPhase = ''
              mkdir -p $out/bin
              cp ./question.beam $out/bin/${name}.beam
              makeWrapper ${pkgs.erlang}/bin/escript $out/bin/${name} --add-flags $out/bin/${name}.beam
            '';
          };

          defaultApp = app.${name};

          devShell = pkgs.mkShell {
            name = "devshell";
            nativeBuildInputs = [ pkgs.erlang ];
          };
        };
    };
}
