{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.nim ];
}
