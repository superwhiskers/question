{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.myrddin ];
}
