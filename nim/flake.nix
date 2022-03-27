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
          name = "question-nim";
          pkgs = channels.nixpkgs;
          inherit (pkgs) nimPackages;
        in
        rec {
          packages = {
            ${name} = nimPackages.buildNimPackage {
              pname = name;
              version = "0.1";
              nimBinOnly = true;

              src = builtins.path {
                path = ./.;
                name = name;
              };

              postFixup = ''
                mv $out/bin/question $out/bin/${name}
              '';
            };
          };

          defaultApp = packages.${name};

          devShell = channels.nixpkgs.mkShell {
            name = "devshell";
            nativeBuildInputs = [ channels.nixpkgs.nim ];
          };
        };
    };
}
