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
          name = "question-python";
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
              pkgs.python3
              pkgs.makeWrapper
            ];

            installPhase = ''
              mkdir -p $out/bin
              cp ./question.py $out/bin/${name}.py
              makeWrapper ${pkgs.python3}/bin/python $out/bin/${name} --add-flags $out/bin/${name}.py
            '';
          };

          defaultApp = app.${name};

          devShell = pkgs.mkShell {
            name = "devshell";
            nativeBuildInputs = [ pkgs.python3 ];
          };
        };
    };
}
