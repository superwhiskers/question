{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.oakc ];
}
