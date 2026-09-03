# SQLFormatteR (development version)

- Bump the `extendr` crates to 0.9.0, which drops the `R_NamespaceRegistry`
  binding. This clears the `R CMD check` NOTE "Found non-API call to R:
  'R_NamespaceRegistry'".
- Re-vendor the Rust dependencies and regenerate `inst/AUTHORS.md`.
- `vendor-authors.R` now falls back to a crate's repository when it
  declares no `authors`, so the `extendr` and `winnow` crates stay
  credited in `inst/AUTHORS.md`.
- Migrate the package scaffolding to `rextendr` 0.5.0. `R/extendr-wrappers.R`
  is now generated during the build by a small `document` binary
  (`src/rust/document.rs`) rather than by `rextendr::register_extendr()`, and
  the package gains `cleanup`/`cleanup.win`. `src/entrypoint.c` now registers
  extendr's panic hook.
- Move the `@noRd`/`@keywords internal` roxygen tags for `sql_format_wrapper`
  into the Rust doc comment, so they survive wrapper regeneration.
- Add a Nix flake providing a development shell with R, the Rust toolchain and
  the package's R dependencies (`nix develop`).
- Drop `renv` from the development setup. `DESCRIPTION` is the only dependency
  manifest now, which is what the CI workflows already installed from.

# SQLFormatteR 0.0.2

- Bump version of extendr and Makevars template for CRAN compliance

# SQLFormatteR 0.0.1

## Changes

- Initial release
