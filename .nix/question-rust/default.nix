{ rustPlatform, ... }:

rustPlatform.buildRustPackage rec {
  name = "question-rust";

  src = builtins.path {
    path = ../../rust;
    name = name;
  };

  cargoLock = {
    lockFile = ../../rust/Cargo.lock;
  };

  meta.mainProgram = "question";
}
