# SQLFormatteR (development version)

* The `extendr` crates have been bumped to 0.9.0, which drops the
  `R_NamespaceRegistry` binding and clears the `R CMD check` NOTE "Found
  non-API call to R: 'R_NamespaceRegistry'".

* The package scaffolding now uses `rextendr` 0.5.0.
  `R/extendr-wrappers.R` is generated during the build by a small `document`
  binary (`src/rust/document.rs`), and `src/entrypoint.c` registers extendr's
  panic hook.

* `inst/AUTHORS.md` now credits the `extendr` and `winnow` crates, which
  declare no `authors` field.

# SQLFormatteR 0.0.2

* Bump version of extendr and Makevars template for CRAN compliance

# SQLFormatteR 0.0.1

## Changes

* Initial release
