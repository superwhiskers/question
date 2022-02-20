{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    utils.url = github:gytis-ivaskevicius/flake-utils-plus;
  };

  outputs = inputs@{ self, nixpkgs, utils }:
    utils.lib.mkFlake {
      inherit self inputs;

      outputsBuilder = channels:
        let pkgs = channels.nixpkgs; in
        {
          defaultApp =
            let
              name = "question-nodejs";
            in
            pkgs.stdenv.mkDerivation {
              name = name;

              src = builtins.path {
                path = ./.;
                name = name;
              };

              buildInputs = [
                pkgs.nodejs-17_x
                pkgs.makeWrapper
              ];

              installPhase = ''
                runHook preInstall

                mkdir -p $out/bin
                cp package.json $out/bin/package.json
                cp ./question.js $out/bin/${name}.js
                makeWrapper ${pkgs.nodejs-17_x}/bin/node $out/bin/${name} --add-flags $out/bin/${name}.js
          
                runHook postInstall
              '';
            };

          devShell = pkgs.mkShell {
            name = "devshell";
            nativeBuildInputs = [ pkgs.nodejs-17_x ];
          };
        };
    };
}
