{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.rustup ];
}
