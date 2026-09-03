#' Extra bullets for the release checklist
#'
#' Picked up by `usethis::use_release_issue()`, which appends these to the
#' standard checklist. They cover the Rust side of the package, which the
#' generic checklist knows nothing about.
#'
#' @noRd
#' @keywords internal
release_bullets <- function() {
  c(
    "`just build-vendor` (re-vendor crates after a `Cargo.toml` change)",
    "`just document-vendor` (regenerate `inst/AUTHORS.md`)",
    "Check `Config/SQLFormatteR/MSRV` against the crates' MSRV",
    "`env -u NOT_CRAN R CMD check --as-cran` (offline vendored build)"
  )
}
