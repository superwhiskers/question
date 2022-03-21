{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    utils.url = github:gytis-ivaskevicius/flake-utils-plus;
  };

  outputs = inputs@{ self, nixpkgs, utils }:
    let
      name = "question-uxn";
    in
    utils.lib.mkFlake {
      inherit self inputs;

      sharedOverlays = [
        (self: super: {
          uxn = super.uxn.overrideAttrs (old: {
            version = "85a6d348ba93186eaa328f67c625fea1bacae1f4";
            src = super.fetchFromSourcehut {
              owner = "~rabbits";
              repo = old.pname;
              rev = "85a6d348ba93186eaa328f67c625fea1bacae1f4";
              hash = "sha256-6xd3bvNIaaXNwKpN9+Lolg9qgiSqBjTi6nWyPuHaa3c=";
            };

            buildPhase = ''
              runHook preBuild

              ./build.sh --no-run

              runHook postBuild
            '';

            installPhase = ''
              runHook preInstall

              ls
              install -d $out/bin/ $out/share/${old.pname}/
              cp ./bin/uxnasm ./bin/uxncli ./bin/uxnemu $out/bin/
              cp -r projects $out/share/${old.pname}/

              runHook postInstall
            '';
          });
        })
      ];

      outputsBuilder = channels: rec {
        packages = {
          ${name} = channels.nixpkgs.stdenv.mkDerivation {
            name = name;

            src = builtins.path {
              path = ./.;
              name = name;
            };

            nativeBuildInputs = [
              channels.nixpkgs.uxn
              channels.nixpkgs.makeWrapper
            ];

            buildPhase = ''
              runHook preBuild

              uxnasm main.tal question.rom

              runHook postBuild
            '';

            installPhase = ''
              runHook preInstall
                
              mkdir -p $out/share/uxn
              cp ./question.rom $out/share/uxn/${name}.rom
              makeWrapper ${channels.nixpkgs.uxn}/bin/uxncli $out/bin/${name} --add-flags $out/share/uxn/${name}.rom

              runHook postInstall
            '';
          };
        };

        defaultPackage = packages.${name};
        defaltApp = packages.${name};

        devShell = channels.nixpkgs.mkShell {
          name = "devshell";
          nativeBuildInputs = [ channels.nixpkgs.uxn ];
        };
      };
    };
}
