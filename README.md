# Creating Elixir project

`mix phx.new hello`

# Commands

## nix build

### building default target

> nix build

Equates `nix build .#default`

Build output is located in a local directory: `ls ./result`

`.#` means local directory.

### building an specific target

> nix build .#hello

### building remote repository

> nix build github:superherointj/nix-elixir-app-demo#hello

**Any** Nix user, anywhere, can build remote repositories like this.

## running applications

> nix run

Equal nix run .#default

> nix run .#hello

Executes application defined at `meta.mainProgram`.
Allows parametrization of commands using argument `--`. Like:

> nix run .#tfk8s -- --version

> nix run .#hello -- "world"

Remote execution:

> nix run github:superherointj/nix-elixir-app-demo#hello

## nix develop (shell for package)

> nix develop

Equates `nix develop .#default`

A specific package shell:

> nix develop .#hello


# Appendice

## Nix building library targets

Depending on output target (for libs usually)

> nix build .#hello.dev # Source code / C/C++ Headers

> nix build .#hello.lib # Dynamic Library

> nix build .#hello.static # Static Library

Outputs at:
 `./result-dev`
 `./result-lib`
 `./result-static`
