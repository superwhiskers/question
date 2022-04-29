{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.dyon ];
}
