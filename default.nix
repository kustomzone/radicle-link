{ sources ? import ./nix/sources.nix
, pkgs ? import sources.nixpkgs {
    overlays = [ (import sources.rust-overlay) ];
  }
}:
let
  rust = pkgs.rust-bin.stable.latest.default;
in
  with pkgs;
  mkShell {
    name = "build";
    buildInputs = [
        # cargo tooling
        cargo-deny
        cargo-watch
        pkgs.rust-bin.nightly."2021-12-02".rustfmt

        # hard dependencies
        cmake
        openssl
        pkgconfig
        rust
    ];
  }
