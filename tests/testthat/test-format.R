library(SQLFormatteR)

test_that("simple SELECT", {
  query_formatted <- SQLFormatteR::sql_format("SELECT    A FROM B")
  expect_equal(query_formatted, "SELECT\n  A\nFROM\n  B")
})

test_that("query must be a string - non-string input", {
  expect_error(
    SQLFormatteR::sql_format(123),
    "query must be a character string"
  )
})

test_that("indent must be a positive integer - negative value", {
  expect_error(
    SQLFormatteR::sql_format("SELECT * FROM table", indent = -1),
    "indent must be a positive integer"
  )
})

test_that("indent must be a positive integer - non-integer input", {
  expect_error(
    SQLFormatteR::sql_format("SELECT * FROM table", indent = "2"),
    "indent must be a positive integer"
  )
})

test_that("uppercase must be logical - non-logical input", {
  expect_error(
    SQLFormatteR::sql_format("SELECT * FROM table", uppercase = "TRUE"),
    "uppercase must be TRUE or FALSE"
  )
})

test_that("lines_between_queries must be a positive integer - negative value", {
  expect_error(
    SQLFormatteR::sql_format("SELECT * FROM table", lines_between_queries = -1),
    "lines_between_queries must be a positive integer"
  )
})

test_that("lines_between_queries must be a positive integer - non-integer input", {
  expect_error(
    SQLFormatteR::sql_format("SELECT * FROM table", lines_between_queries = "1"),
    "lines_between_queries must be a positive integer"
  )
})


test_that("indent argument works correctly", {
  query <- "SELECT A FROM B"
  expect_equal(
    SQLFormatteR::sql_format(query, indent = 4),
    "SELECT\n    A\nFROM\n    B"
  )
})

test_that("uppercase argument works correctly", {
  query <- "select a from b"
  expect_equal(
    SQLFormatteR::sql_format(query, uppercase = FALSE),
    "select\n  a\nfrom\n  b"
  )
})

test_that("lines_between_queries argument works correctly", {
  queries <- "SELECT * FROM table1; SELECT * FROM table2"
  expect_equal(
    SQLFormatteR::sql_format(queries, lines_between_queries = 3),
    "SELECT\n  *\nFROM\n  table1;\n\n\nSELECT\n  *\nFROM\n  table2"
  )
})
