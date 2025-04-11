//! This is the R wrapper of https://github.com/shssoichiro/sqlformat-rs

use extendr_api::prelude::*;
use extendr_macros::TryFromRobj;
use sqlformat::{FormatOptions, Indent, QueryParams};

/// Options for controlling how the library formats SQL
#[derive(Debug, Clone, TryFromRobj)] 
struct RFormatOptions {
    pub indent: Option<usize>,
    pub uppercase: Option<bool>,
    pub lines_between_queries: u8,
}

impl RFormatOptions {
    fn to_sql_format(&self) -> FormatOptions {
        FormatOptions {
            indent: Indent::Spaces(self.indent.unwrap_or(2) as u8),
            uppercase: self.uppercase,
            lines_between_queries: self.lines_between_queries,
            ignore_case_convert: None,
        }
    }
}
/// Formats whitespace in a SQL string to make it easier to read.
/// Optionally replaces parameter placeholders with `params`.
#[extendr]
fn sql_format_wrapper(query: &str, options: RFormatOptions) -> String {
    let params = QueryParams::default();
    let options_sql_format = options.to_sql_format();

    sqlformat::format(&query, &params, &options_sql_format)
}

// Macro to generate exports.
// This ensures exported functions are registered with R.
// See corresponding C code in `entrypoint.c`.
extendr_module! {
    mod SQLFormatteR;
    fn sql_format_wrapper;
}
