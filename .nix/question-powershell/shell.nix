{ pkgs, ... }: pkgs.mkShell {
  buildInputs = [ pkgs.powershell ];
}
