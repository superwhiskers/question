{ lib
, rustPlatform
, fetchCrate
, ...
}:

rustPlatform.buildRustPackage rec {
  pname = "dyon";
  version = "0.47.3";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-hShe8Mj8lEuyXwaOz5lraSA+AEQUx6BknIR/WezTxOQ=";
  };
  cargoHash = "sha256-8tG4dnmb5kzX6JTWDPkbltxlxzCFxXP8G6K6PGDCVxQ=";

  dontCargoCheck = true;

  buildPhase = ''
    cargo build --example dyonrun --release        
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp ./target/release/examples/dyonrun $out/bin
  '';

  meta = with lib; {
    description = "A rusty dynamically typed scripting language";
    homepage = "https://github.com/PistonDevelopers/dyon";
    license = licenses.asl20;
    mainProgram = "dyonrun";
  };
}
