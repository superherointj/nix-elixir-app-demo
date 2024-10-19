{
  lib,
  pkgs,
  withSystemd ? true
}:

let
  beamPkgs = (if withSystemd == true then pkgs.beam_nox else pkgs.beam_minimal).packages.erlang.beamPackages;

  pname = "nix-elixir-app-demo-shell";
  version = "0.0.1";
  src = ./hello/.;

  mixFodDeps = beamPkgs.fetchMixDeps {
    pname = "${pname}-deps";
    inherit src version;
    sha256 = "sha256-2VgeypW2+xH0ZfBNW04tENdKRXvre8/2DBliqrEy9fQ="; # test
    # mixEnv = "test";
  };

  hello-pkg =
    beamPkgs.mixRelease {
      inherit pname version src mixFodDeps;

      nativeBuildInputs = with pkgs; [ nodejs ];

      # LC_ALL="en_US.UTF-8";
      # LANG="en_US.UTF-8";

      MIX_ESBUILD_PATH="${pkgs.esbuild}/bin/esbuild";
      MIX_ESBUILD_VERSION="${pkgs.esbuild.version}";

      buildPhase = ''
        export RELEASE_COOKIE=your_cookie_value
        mix release
      '';

      # postBuild = ''
      #   export NODE_PATH="assets/node_modules"
      #   rm assets/package.json
      #   mkdir -p assets/node_modules
      #   ln -s ${mixFodDeps}/phoenix assets/node_modules/phoenix
      #   ln -s ${mixFodDeps}/phoenix_html assets/node_modules/phoenix_html
      #   ln -s ${mixFodDeps}/phoenix_live_view assets/node_modules/phoenix_live_view
      #   mix assets.deploy --no-deps-check
      # '';

      # nativeCheckInputs = [ pkgs.postgresqlTestHook ];
      # checkInputs = [ pkgs.postgresql ];

      # CREATE DATABASE "$PGDATABASE" ENCODING='UTF8' OWNER '$PGUSER';
      # postgresqlTestUserOptions = "LOGIN";

      # checkPhase = ''
      #   # Use usuario postgres
      #   runHook preCheck
      #   export PGUSER=postgres
      #   export PGDATABASE=leanci_test_nix
      #   export postgresqlTestSetupCommands=`cat <<EOF
      #   CREATE ROLE "$PGUSER" $postgresqlTestUserOptions;
      #   CREATE DATABASE "$PGDATABASE" WITH ENCODING='UTF8' OWNER '$PGUSER';
      #   EOF`
      #   export postgresqlTestSetupCommands=`echo "''$postgresqlTestSetupSQL" | psql postgres`
      #   MIX_ENV=test mix test --no-deps-check
      #   runHook postCheck
      # '';
      doCheck = false;

      meta = {
        description = "Elixir App demo";
        license = lib.licenses.mit;
        # homepage = "https://github.com/superherointj/nix-elixir-app-demo";
        # maintainers = [ lib.maintainers.superherointj ];
      };
    };
  in
    hello-pkg


###
# https://nixos.org/manual/nixpkgs/unstable/#sec-beam