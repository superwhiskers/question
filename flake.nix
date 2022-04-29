{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-deno.url = "github:brecert/nix-deno";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, nix-deno, fenix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ nix-deno.overlay overlay ];
          config.allowUnfree = true;
        };

        rust = import fenix { inherit system; };

        inherit (pkgs) lib callPackage makeRustPlatform fetchCrate;
        inherit (builtins) attrNames substring readDir baseNameOf;

        rustPlatform = makeRustPlatform {
          inherit (rust.minimal) cargo rustc;
        };

        mkPackages = pkgs: {
          oak = callPackage ./.nix/oak pkgs;
          dyon = callPackage ./.nix/dyon { inherit pkgs rustPlatform; };
          oakc = callPackage ./.nix/oakc { inherit pkgs rustPlatform; };
          sidef = callPackage ./.nix/sidef pkgs;
        };

        overlay = final: prev: ({
          # update uxn
          uxn = prev.uxn.overrideAttrs (old: {
            version = "85a6d348ba93186eaa328f67c625fea1bacae1f4";
            src = prev.fetchFromSourcehut {
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
        } // mkPackages prev);

        importFlakeOutputs = name: path: pkgs: {
          packages.${name} = callPackage path pkgs;
          shells.${name} = callPackage (path + "/shell.nix") pkgs;
        };

        flattenAttrList = lib.lists.foldr (a: b: lib.recursiveUpdate a b) { };
      in
      flattenAttrList (lib.lists.flatten [
        {
          packages = mkPackages pkgs;

          lib = {
            inherit importFlakeOutputs flattenAttrList;
          };
        }

        # importFlakeOutputs on any dirs starting with "question" in .nix/
        (map
          (path: importFlakeOutputs (baseNameOf path) (./.nix + "/${path}") pkgs)
          (attrNames (lib.attrsets.filterAttrs
            (path: type: type == "directory" && (substring 0 8 path) == "question")
            (readDir ./.nix)
          ))
        )
      ])
    );
}
