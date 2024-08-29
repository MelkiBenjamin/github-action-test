FROM rust:1.80.1 AS builder

# install lib musl
RUN USER=root cargo new --bin product-service

# Create a new directory for our application
WORKDIR /product-service

# Set the build argument for the app version number
ARG APP_VERSION=0.1.0

# Copy the source files to the container
COPY . ./ 

#Build the application with libc musl 
#RUN addgroup -S appgroup && adduser -S benjamin -G appgroup 
Run apt update && apt install -y musl-tools
RUN rustup target add x86_64-unknown-linux-musl
run rustup toolchain install nightly
RUN cargo +nightly build --release --target x86_64-unknown-linux-musl -Z threads=4
run ls /product-service/target/release/
run ls /product-service/target/release/deps
run ls /product-service/target/release/build
run ls /product-service/target/
RUN ls /product-service/target/x86_64-unknown-linux-musl/release
run cargo metadata --format-version 1 | grep target
run find target/ -type f -executable

# Create a new stage and copy the binary from the builder stage busybox with glibc
FROM scratch AS app
WORKDIR /app

# Set the build argument for the app version number
ARG APP_VERSION=0.1.0

# Not ideal but needed to execute health checks in docker-compose
#RUN apt-get update && apt-get install -y wget

# Copy the binary from the builder stage
#COPY --from=builder /etc/passwd /etc/group /etc/  
COPY --from=builder /product-service/target/x86_64-unknown-linux-musl/release/product-service .

#USER benjamin

# Set the environment variable for the app version number
ENV APP_VERSION=$APP_VERSION

# Run the application
CMD ["./product-service"]
