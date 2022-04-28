{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.elixir ];
}
