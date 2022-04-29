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
        
        importFlakeOutputs = name: path: pkgs: {
          packages.${name} = callPackage path pkgs;
          shells.${name} = callPackage (path + "/shell.nix") pkgs;
        };

        flattenAttrList = lib.lists.foldr (a: b: lib.recursiveUpdate a b) { };

        packages = {
          oak = callPackage ./.nix/oak pkgs;
          dyon = callPackage ./.nix/dyon { inherit pkgs rustPlatform; };
          oakc = callPackage ./.nix/oakc { inherit pkgs rustPlatform; };
          sidef = callPackage ./.nix/sidef pkgs;
        };

        overlay = final: prev: packages;
      in
      flattenAttrList (lib.lists.flatten [
        {
          inherit packages;
          lib = { inherit importFlakeOutputs; };
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
