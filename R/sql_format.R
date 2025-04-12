#' Format an SQL Query
#'
#' This function formats an SQL query based on various styling options.
#'
#' @param query A character string containing the SQL query to format.
#' @param indent An integer specifying the number of spaces for indentation
#'   (default: 2).
#' @param uppercase A logical value indicating whether SQL keywords should
#'   be converted to uppercase (default: TRUE).
#' @param lines_between_queries An integer specifying the number of blank
#'   lines between queries (default: 1).
#'
#' @return A formatted SQL query as a character string.
#'
#' @examples
#' formatted_query <- sql_format("SELECT * FROM users WHERE id = 1")
#' cat(formatted_query)
#'
#' @export
#' @importFrom assertthat assert_that is.string is.count is.flag
#' @useDynLib SQLFormatteR, sql_format_wrapper
sql_format <- function(
    query,
    indent = 2L,
    uppercase = TRUE,
    lines_between_queries = 1L) {
  # Input validation using assertthat
  assertthat::assert_that(assertthat::is.string(query),
    msg = "query must be a character string"
  )
  assertthat::assert_that(assertthat::is.count(indent),
    msg = "indent must be a positive integer"
  )
  assertthat::assert_that(assertthat::is.flag(uppercase),
    msg = "uppercase must be TRUE or FALSE"
  )
  assertthat::assert_that(assertthat::is.count(lines_between_queries),
    msg = "lines_between_queries must be a positive integer"
  )

  .Call(
    sql_format_wrapper, query, as.integer(indent), as.logical(uppercase),
    as.integer(lines_between_queries)
  )
}
