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
#' @param ignore_case_convert A logical value indicating whether to
#'   case conversion (default: NULL).
#'
#' @return A formatted SQL query as a character string.
#'
#' @examples
#' formatted_query <- sql_format("SELECT * FROM users WHERE id = 1")
#' cat(formatted_query)
#'
#' @export
sql_format <- function(
    query,
    indent = 2L,
    uppercase = TRUE,
    lines_between_queries = 1L,
    ignore_case_convert = NULL) {
  assertthat::assert_that(
    assertthat::is.string(query),
    msg = "Query must be a string!"
  )

  options <- list(
    indent = indent,
    uppercase = uppercase,
    lines_between_queries = lines_between_queries,
    ignore_case_convert = ignore_case_convert
  )

  sql_format_wrapper(query, options)
}
