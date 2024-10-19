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

## Update dependencies

> nix flake update

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

# Automatic loading of nix shell

Requires dir-env (https://direnv.net/).

# Creating an Elixir Phoenix Project

Delete "hello" application:

> rm -rf hello

Re-generate hello application:

> mix phx.new hello

Reference: https://hexdocs.pm/phoenix/up_and_running.html

# Executing project

Because of RELEASE_COOKIE, start package as:

> DATABASE_URL=ecto://USER:PASS@HOST/DATABASE RELEASE_COOKIE=xxxx ./result/bin/hello start

# Kubernetes Cluster

- Running Elixir containers connected (as a single application)
    - libcluster: https://github.com/bitwalker/libcluster

- Preserving state when losing nodes
  - DeltaCrdt: 
    - https://jumpwire.io/blog/in-memory-distributed-state-with-delta-crdts
    - https://github.com/derekkraan/delta_crdt_ex
  - Horde: https://github.com/derekkraan/horde
  - raft_kv: https://github.com/skirino/raft_kv
