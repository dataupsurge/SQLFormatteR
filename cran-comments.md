## R CMD check results

0 errors | 0 warnings | 0 notes

## Changes in this release

This is an update to SQLFormatteR 0.0.2, currently on CRAN.

The vendored `extendr` crates have been bumped to 0.9.0, which removes the
non-API call to `R_NamespaceRegistry` from the compiled code.

## Tarball size

The vendored Rust dependencies are compressed as aggressively as possible,
following the approach used by the `arcpbf` package (another Rust-wrapper R
package): all Cargo/Rust dependencies are bundled in a single `vendor.tar.xz`
archive at xz compression level 9.
