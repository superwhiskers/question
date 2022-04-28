{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.oak ];
}
