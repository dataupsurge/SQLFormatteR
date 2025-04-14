  <!-- badges: start -->
  [![Codecov test coverage](https://codecov.io/gh/dataupsurge/SQLFormatteR/graph/badge.svg)](https://app.codecov.io/gh/dataupsurge/SQLFormatteR)
  [![R-CMD-check](https://github.com/dataupsurge/SQLFormatteR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dataupsurge/SQLFormatteR/actions/workflows/R-CMD-check.yaml)
  <!-- badges: end -->

# SQLFormatteR

**SQLFormatteR** is an R package that provides an easy-to-use wrapper for the [`sqlformat-rs`](https://github.com/shssoichiro/sqlformat-rs) Rust-based SQL formatter. It allows you to format SQL queries with support for various SQL dialects directly in R.

## Features

- Simple and seamless integration with R.
- Maintains SQL query readability and consistency.
- Supports standard SQL formatting options.

### Limitations

- Does **not** support formatting **stored procedures**.
- Only supports the `;` delimiter for SQL statements (custom delimiters are not available).

## Installation

You can install **SQLFormatteR** from GitHub using:

```r
# Install devtools if not already installed
if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")

remotes::install_github("dataupsurge/SQLFormatteR")
```

## Usage

```r
library(SQLFormatteR)

sql_query <- "SELECT * FROM users WHERE age > 18 ORDER BY name;"

formatted_sql <- sql_format(sql_query)

cat(formatted_sql)
```

## Contributing

We welcome contributions! Feel free to submit issues or pull requests to improve the package.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

It depends on sqlformat-rs, which is also licensed under MIT.

When distributing this package, you must retain the original MIT license notice.

---

⭐ If you find this package useful, please consider giving it a star on GitHub!
