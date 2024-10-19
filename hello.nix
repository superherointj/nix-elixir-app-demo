{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "nix-elixir-app-demo-shell";
  version = "0.0.1";

  buildInputs = with pkgs; [
    elixir
  ];

}
