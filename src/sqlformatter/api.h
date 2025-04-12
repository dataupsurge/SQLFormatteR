#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

char * sql_format(const char* query, int indent, bool uppercase, int lines_between_queries);
void free_string_from_rust(char*);

#ifdef __cplusplus
}
#endif
