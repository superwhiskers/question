{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.sidef ];
}
