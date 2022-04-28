{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-deno.url = "github:brecert/nix-deno";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, nix-deno }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ nix-deno.overlay ];
        };
        inherit (pkgs) lib callPackage;
        importFlakeOutputs = name: path: pkgs: {
          packages.${name} = callPackage path pkgs;
          shells.${name} = callPackage (path + "/shell.nix") pkgs;
        };
        flattenAttrList = lib.lists.foldr (a: b: lib.recursiveUpdate a b) { };
        inherit (builtins) attrNames substring readDir baseNameOf;
      in
      flattenAttrList (lib.lists.flatten [
        { lib = { inherit importFlakeOutputs; }; }

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
