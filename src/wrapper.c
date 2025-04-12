#include <Rinternals.h>

// Import C headers for rust API
#include "sqlformatter/api.h"

// Actual Wrappers
SEXP sql_format_wrapper(SEXP query, SEXP indent, SEXP uppercase, SEXP lines_between_queries){
  if (TYPEOF(query) != STRSXP)
    Rf_error("'query' must be a string");
  if (TYPEOF(indent) != INTSXP)
    Rf_error("'indent' must be an integer");
  if (TYPEOF(uppercase) != LGLSXP)
    Rf_error("'uppercase' must be a logical value");
  if (TYPEOF(lines_between_queries) != INTSXP)
    Rf_error("'lines_between_queries' must be an integer");
    
  const char* query_str = CHAR(STRING_ELT(query, 0));
  int indent_val = INTEGER(indent)[0];
  int uppercase_val = LOGICAL(uppercase)[0];
  int lines_val = INTEGER(lines_between_queries)[0];
  
  char* formatted_sql = sql_format(query_str, indent_val, uppercase_val, lines_val);
  SEXP formatted_string = PROTECT(Rf_mkCharCE(formatted_sql, CE_UTF8));
  free_string_from_rust(formatted_sql);
  UNPROTECT(1);
  return Rf_ScalarString(formatted_string);
}


// Standard R package stuff
static const R_CallMethodDef CallEntries[] = {
  {"sql_format_wrapper", (DL_FUNC) &sql_format_wrapper, 4},
  {NULL, NULL, 0}
};

void R_init_SQLFormatteR(DllInfo *dll) {
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
