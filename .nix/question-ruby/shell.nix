{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.rakudo ];
}
