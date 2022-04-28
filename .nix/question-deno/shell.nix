{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.deno ];
}
