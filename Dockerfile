FROM rust:1.44 as build

# app
ENV app=rusty-ocean

# dependencies
WORKDIR /tmp/${app}
COPY Cargo.toml Cargo.lock ./

# compile dependencies
RUN set -x\
 && mkdir -p src\
 && echo "fn main() {println!(\"broken\")}" > src/main.rs\
 && cargo build --release

# copy source and rebuild
COPY src/ src/
RUN set -x\
 && find target/release -type f -name "$(echo "${app}" | tr '-' '_')*" -exec touch -t 200001010000 {} +\
 && cargo build --release
