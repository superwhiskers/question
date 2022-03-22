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
          name = "question-powershell";
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
              pkgs.powershell
              pkgs.makeWrapper
            ];

            installPhase = ''
              mkdir -p $out/bin
              cp ./question.ps1 $out/bin/${name}.ps1
              makeWrapper ${pkgs.powershell}/bin/pwsh $out/bin/${name} --add-flags $out/bin/${name}.ps1
            '';
          };

          defaultApp = app.${name};

          devShell = pkgs.mkShell {
            name = "devshell";
            nativeBuildInputs = [ pkgs.powershell ];
          };
        };
    };
}
