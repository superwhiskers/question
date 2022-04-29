{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.zig ];
}
