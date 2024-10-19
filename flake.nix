# Flake.nix is an interface. Schema available at:
# https://nixos.wiki/wiki/Flakes

{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.nixpkgs.follows = "nixpkgs"; # Syncs flake-utils's nixpkgs with our defined nixpkgs (nixos-unstable)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        packages = rec {
          hello = pkgs.callPackage ./hello.nix { };
          hello-container = pkgs.callPackage ./hello-container.nix {
            inherit hello;
          };
          default = hello;
        };
        apps = rec {
          hello = flake-utils.lib.mkApp { drv = self.packages.${system}.hello; };
          default = hello;
        };
        devShells = rec {
          hello = pkgs.callPackage ./hello-shell.nix { };
          default = hello;
        };
      }
    );

} # End of Flake
