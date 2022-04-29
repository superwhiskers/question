{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.gnu-cobol ];
}
