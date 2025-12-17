# SPDX-License-Identifier: MIT OR AGPL-3.0-or-later
# SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
#
# SuperNorma - Nix Flake
# This is the fallback package manager (primary: Guix)
# Run: nix develop or nix build

{
  description = "SuperNorma - Super normalized data structures for financial self-awareness";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        # Development shell with ReScript and Deno
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # ReScript / JavaScript runtime
            deno
            nodejs_20

            # Build tools
            just
            gnumake

            # Version control
            git

            # Security tools
            trufflehog
          ];

          shellHook = ''
            echo "SuperNorma development environment"
            echo "Primary package manager: Guix (guix.scm)"
            echo "Fallback: Nix (this flake)"
            echo ""
            echo "Available commands:"
            echo "  just build  - Build the project"
            echo "  just test   - Run tests"
            echo "  just lint   - Run linters"
            echo "  deno task   - Run Deno tasks"
          '';
        };

        # Package definition
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "supernorma";
          version = "0.1.0";

          src = ./.;

          buildInputs = with pkgs; [
            deno
            nodejs_20
          ];

          # Build phase - currently minimal
          buildPhase = ''
            echo "Building SuperNorma..."
          '';

          installPhase = ''
            mkdir -p $out
            cp -r src $out/
            cp -r ui $out/ 2>/dev/null || true
            cp -r data $out/ 2>/dev/null || true
            cp LICENSE.txt $out/
            cp README.adoc $out/
          '';

          meta = with pkgs.lib; {
            description = "Super normalized data structures for financial self-awareness";
            homepage = "https://github.com/hyperpolymath/SuperNorma";
            license = with licenses; [ mit agpl3Plus ];
            maintainers = [ ];
            platforms = platforms.all;
          };
        };
      }
    );
}
