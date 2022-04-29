{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.ciao ];
}
