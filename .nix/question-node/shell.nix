{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.nodejs-17_x ];
}
