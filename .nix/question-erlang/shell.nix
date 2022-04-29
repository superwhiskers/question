{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.erlang ];
}
