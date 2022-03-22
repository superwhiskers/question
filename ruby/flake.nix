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
              name = "question-ruby";
            in
            pkgs.stdenv.mkDerivation {
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

          devShell = pkgs.mkShell {
            name = "devshell";
            nativeBuildInputs = [ pkgs.ruby ];
          };
        };
    };
}
