{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.uxn ];
}
