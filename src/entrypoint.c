// We need to forward routine registration from C to Rust
// to avoid the linker removing the static library.

void R_init_SQLFormatteR_extendr(void *dll);

void R_init_SQLFormatteR(void *dll) {
    R_init_SQLFormatteR_extendr(dll);
}
