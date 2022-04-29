{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.janet ];
}
