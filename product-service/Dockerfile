FROM rust:1.80.1 AS builder

# new projet rust
RUN USER=root cargo new --bin product-service

# Create a new directory for our application
WORKDIR /product-service

# Set the build argument for the app version number
ARG APP_VERSION=0.1.0

# Copy the source files to the container
COPY . ./ 

#Build the application with libc musl 
#RUN addgroup -S appgroup && adduser -S benjamin -G appgroup 
Run rustup toolchain install nightly \
  && rustup default nightly \
  && apt update && apt install -y musl-tools \
  && rustup target add x86_64-unknown-linux-musl \
  && rustup show active-toolchain \
  && rustup target list --installed \
  && RUSTFLAGS="-Z threads=8" cargo +nightly build --release --target x86_64-unknown-linux-musl
#RUN cargo +nightly build --release --target x86_64-unknown-linux-musl -Z threads=4

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
