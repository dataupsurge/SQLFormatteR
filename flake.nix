{
  description = "Development environment for SQLFormatteR (R + Rust/extendr)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      # Pins for the two packages where the nixpkgs version is the wrong one:
      #
      # rextendr: nixpkgs ships 0.4.1, but the scaffolding in this package
      # (src/rust/document.rs, the `cargo run --bin document` step in
      # src/Makevars.in) is the 0.5.0 layout, which is also what DESCRIPTION
      # requires.
      #
      # roxygen2: nixpkgs ships 8.0.0, which would rewrite every Rd file and
      # bump RoxygenNote on the next `just document`. Hold it at the version
      # DESCRIPTION records.
      cranPinsOverlay = final: prev: {
        rPackages = prev.rPackages.override {
          overrides = {
            rextendr = prev.rPackages.buildRPackage {
              pname = "rextendr";
              version = "0.5.0";
              src = final.fetchurl {
                url = "https://cran.r-project.org/src/contrib/rextendr_0.5.0.tar.gz";
                hash = "sha256-RfZfx2bisiiG8uLo+ftZs82jx68Dh44VyD3+zDA6FKs=";
              };
              propagatedBuildInputs = with prev.rPackages; [
                brio
                cli
                desc
                dplyr
                glue
                jsonlite
                lifecycle
                pkgbuild
                processx
                rlang
                rprojroot
                stringi
                usethis # use_rextendr_template() prefers usethis::use_template()
                vctrs
                withr
              ];
            };
            roxygen2 = prev.rPackages.buildRPackage {
              pname = "roxygen2";
              version = "7.3.2";
              src = final.fetchurl {
                url = "https://cran.r-project.org/src/contrib/Archive/roxygen2/roxygen2_7.3.2.tar.gz";
                hash = "sha256-t4iHn5Eyt+LmVvRCpsWSMUZ2qb8y1qClbhVs+hraARw=";
              };
              propagatedBuildInputs = with prev.rPackages; [
                brew
                cli
                commonmark
                cpp11 # LinkingTo
                desc
                knitr
                pkgload
                purrr
                R6
                rlang
                stringi
                stringr
                withr
                xml2
              ];
            };
          };
        };
      };

      forAllSystems =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f (
            import nixpkgs {
              inherit system;
              overlays = [ cranPinsOverlay ];
            }
          )
        );
    in
    {
      devShells = forAllSystems (pkgs: {
        default =
          let
            # R packages from DESCRIPTION (Imports + Suggests) plus the tooling
            # used by the justfile recipes.
            rEnv = pkgs.rWrapper.override {
              packages = with pkgs.rPackages; [
                assertthat
                covr
                devtools
                docopt
                git2r
                jsonlite
                lintr
                optparse
                pkgdown
                precommit
                rextendr
                roxygen2
                styler
                testthat
              ];
            };
          in
          pkgs.mkShell {
            name = "SQLFormatteR";

            packages = [
              rEnv
              pkgs.cargo
              pkgs.clippy
              pkgs.rustc
              pkgs.rustfmt
            ]
            ++ (with pkgs; [
              checkbashisms # `R CMD check` warns about its absence otherwise
              gcc
              gnumake
              just
              pandoc
              pkg-config
              qpdf
              texliveSmall # `R CMD check` builds the PDF manual
              xz # `just build-vendor` compresses vendor.tar.xz
            ])
            # Headers/libraries for R packages built from source into R_LIBS_USER.
            ++ (with pkgs; [
              curl
              fontconfig
              freetype
              fribidi
              harfbuzz
              icu
              libgit2
              libjpeg
              libpng
              libtiff
              libxml2
              openssl
              zlib
            ]);

            shellHook = ''
              # Keep locally installed R packages inside the project so they
              # survive between shells without touching $HOME.
              export R_LIBS_USER="$PWD/.Rlibs"
              mkdir -p "$R_LIBS_USER"

              echo "SQLFormatteR dev shell"
              echo "  $(R --version | head -n 1)"
              echo "  $(rustc --version)  |  $(cargo --version)"
              echo "  rextendr $(Rscript -e 'cat(as.character(packageVersion("rextendr")))' 2>/dev/null)"
            '';
          };
      });

      formatter = forAllSystems (pkgs: pkgs.nixfmt-tree);
    };
}
