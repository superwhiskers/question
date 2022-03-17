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
              name = "question-deno";
            in
            pkgs.stdenv.mkDerivation {
              name = name;

              src = builtins.path {
                path = ./.;
                name = name;
              };

              buildInputs = [
                pkgs.deno
                pkgs.makeWrapper
              ];

              installPhase = ''
                runHook preInstall

                mkdir -p $out/bin
                cp ./question.ts $out/bin/${name}.ts
                makeWrapper ${pkgs.deno}/bin/deno $out/bin/${name} --add-flags "run $out/bin/${name}.ts"
          
                runHook postInstall
              '';
            };

          devShell = pkgs.mkShell {
            name = "devshell";
            nativeBuildInputs = [ pkgs.deno ];
          };
        };
    };
}
