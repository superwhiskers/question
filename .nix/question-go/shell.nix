{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.go ];
}
