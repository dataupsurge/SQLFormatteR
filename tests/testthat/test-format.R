library(SQLFormatteR)

test_that("simple SELECT", {
  query_formatted <- SQLFormatteR::sql_format("SELECT    A FROM B")
  expect_equal(query_formatted, "SELECT\n  A\nFROM\n  B")
})
