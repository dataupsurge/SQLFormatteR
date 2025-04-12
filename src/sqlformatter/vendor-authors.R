#!/usr/bin/env Rscript
library(optparse)
library(jsonlite)
library(cli)


# Define options
option_list <- list(
  make_option(
    c("-m", "--manifest-path"),
    type = "character",
    help = "Path to Cargo.toml",
    metavar = "FILE"
  ),
  make_option(
    c("-o", "--output-path"),
    type = "character",
    help = "Path to the output directory",
    metavar = "FILE"
  ),
  make_option(
    c("-v", "--verbose"),
    action = "store_true",
    default = FALSE,
    help = "Enable verbose mode"
  )
)

# Parse arguments
opt_parser <- OptionParser(option_list = option_list)
opt <- parse_args(opt_parser)

# Use arguments
if (opt$verbose) {
  cli_alert_info("Generating AUTHORS file using Cargo metadata...")
}

metadata <- jsonlite::fromJSON(
  pipe(
    paste(
      "cargo metadata --format-version 1 --manifest-path",
      opt$m
    )
  )
)
packages <- metadata$packages
stopifnot(is.data.frame(packages))
packages <- subset(
  packages,
  sapply(packages$authors, length) > 0 & name != "SQLFormatteR"
)
authors <- vapply(
  packages$authors,
  function(x) {
    paste(
      sub(" <.*>", "", x),
      collapse = ", "
    )
  },
  character(1)
)
lines <- sprintf(
  "- %s %s: %s",
  packages$name,
  packages$version,
  authors
)
dir.create(opt$o, showWarnings = FALSE)
today_date <- Sys.Date()
footer <- sprintf(
  "\n(This file was auto-generated from 'cargo metadata' on %s)",
  today_date
)
writeLines(
  c("# Authors of vendored cargo crates", lines, footer),
  file.path(opt$o, "AUTHORS.md")
)

if (opt$verbose) {
  cli_alert_success("AUTHORS file updated on {today_date}")
}
