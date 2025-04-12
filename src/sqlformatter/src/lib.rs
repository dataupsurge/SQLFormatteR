// Import dependencies
use sqlformat::{FormatOptions, Indent, QueryParams};
use std::ffi::CStr;
use std::ffi::CString;
use std::os::raw::c_char;

#[no_mangle]
pub unsafe extern "C" fn sql_format(
    query: *const c_char,
    indent: i32,
    uppercase: bool,
    lines_between_queries: i32,
) -> *const c_char {
    // Safely convert the C string to a Rust string
    let c_str = {
        if query.is_null() {
            // Default query if NULL is passed
            return CString::new("No query provided").unwrap().into_raw();
        }
        CStr::from_ptr(query)
    };

    // Convert to Rust String, handling potential UTF-8 errors
    let rust_string = match c_str.to_str() {
        Ok(s) => s,
        Err(_) => return CString::new("Invalid UTF-8 in query").unwrap().into_raw(),
    };

    // Determine indent spaces (use 2 if indent is negative or zero)
    // Cap at u8::MAX (255) since Indent::Spaces expects a u8
    let indent_spaces = if indent <= 0 {
        2
    } else if indent > 255 {
        255
    } else {
        indent as u8
    };

    // Handle lines_between_queries similarly
    let lines_between = if lines_between_queries <= 0 {
        1 // Default to 1 if negative or zero
    } else if lines_between_queries > 255 {
        255 // Cap at u8::MAX
    } else {
        lines_between_queries as u8
    };

    // Format the SQL query with the provided options
    let options = FormatOptions {
        indent: Indent::Spaces(indent_spaces),
        uppercase: Some(uppercase),
        lines_between_queries: lines_between,
        ignore_case_convert: None,
    };

    let params = QueryParams::default();
    let formatted_string = sqlformat::format(rust_string, &params, &options);

    // Convert back to C string
    let c_string = CString::new(formatted_string).unwrap();
    c_string.into_raw()
}

#[no_mangle]
pub unsafe extern "C" fn free_string_from_rust(ptr: *mut c_char) {
    if !ptr.is_null() {
        let _ = CString::from_raw(ptr);
    }
}
