{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.perl ];
}
