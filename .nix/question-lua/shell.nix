{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.lua ];
}
