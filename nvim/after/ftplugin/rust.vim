" Rust uses 4 spaces
set shiftwidth=4

let b:ale_rust_cargo_use_clippy = executable('cargo-clippy')
let b:ale_linters = ['cargo']
let b:ale_fixers = ['rustfmt']
