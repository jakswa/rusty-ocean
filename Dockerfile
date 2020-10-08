FROM rust as builder
WORKDIR /usr/src/myapp
COPY . .
RUN cargo install --path .

FROM debian:buster-slim
# RUN apt-get update && apt-get install -y extra-runtime-dependencies && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/cargo/bin/rusty-ocean /usr/local/bin/rusty-ocean

EXPOSE 8080

CMD ["rusty-ocean"]
