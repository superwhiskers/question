{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.python3 ];
}
