{ pkgs }:

pkgs.mkShell {
  pname = "hello-shell";
  version = "0.0.1";

  buildInputs = with pkgs; [
    elixir
    erlang
  ]
  ++ lib.optionals stdenv.isLinux [ pkgs.inotify-tools ]
  ++ lib.optionals stdenv.isDarwin (with pkgs.darwin.apple_sdk.frameworks; [ CoreFoundation CoreServices ]);

  shellHook = ''
    echo "=== nix-elixir-app-demo-shell ==="
  '';
}
