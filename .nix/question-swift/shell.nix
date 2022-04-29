{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.swift ];
}
