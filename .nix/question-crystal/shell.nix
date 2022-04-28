{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.crystal ];
}
