# Format an SQL Query

This function formats an SQL query based on various styling options.

## Usage

``` r
sql_format(
  query,
  indent = 2L,
  uppercase = TRUE,
  lines_between_queries = 1L,
  ignore_case_convert = NULL
)
```

## Arguments

- query:

  A character string containing the SQL query to format.

- indent:

  An integer specifying the number of spaces for indentation (default:
  2).

- uppercase:

  A logical value indicating whether SQL keywords should be converted to
  uppercase (default: TRUE).

- lines_between_queries:

  An integer specifying the number of blank lines between queries
  (default: 1).

- ignore_case_convert:

  A logical value indicating whether to case conversion (default: NULL).

## Value

A formatted SQL query as a character string.

## Examples

``` r
formatted_query <- sql_format("SELECT * FROM users WHERE id = 1")
cat(formatted_query)
#> SELECT
#>   *
#> FROM
#>   users
#> WHERE
#>   id = 1
```
