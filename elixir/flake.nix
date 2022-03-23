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
          name = "question-elixir";
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
              pkgs.elixir
              pkgs.makeWrapper
            ];

            installPhase = ''
              mkdir -p $out/bin
              cp ./question.ex $out/bin/${name}.ex
              makeWrapper ${pkgs.elixir}/bin/elixir $out/bin/${name} --add-flags $out/bin/${name}.ex
            '';
          };

          defaultApp = app.${name};

          devShell = pkgs.mkShell {
            name = "devshell";
            nativeBuildInputs = [ pkgs.elixir ];
          };
        };
    };
}
