{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.odin ];
}
