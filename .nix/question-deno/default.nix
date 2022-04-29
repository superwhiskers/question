{ mkDenoDrv, writeText, ... }:
mkDenoDrv {
  name = "question-deno";
  src = builtins.path {
    path = ../../js/deno;
    name = "question-deno";
  };
  lockfile = writeText "lockfile.json" "{}";
  entrypoint = "question.ts";
}
