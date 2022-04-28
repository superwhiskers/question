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
        importFlakeOutputs = name: path: {
          packages.${name} = callPackage path pkgs;
          shells.${name} = callPackage (path + "/shell.nix") pkgs;
        };
        flattenAttrList = lib.lists.foldr (a: b: lib.recursiveUpdate a b) { };
      in
      flattenAttrList [
        { lib = { inherit importFlakeOutputs; }; }
        (importFlakeOutputs "question-deno" ./.nix/question-deno)
      ]
    );
}
