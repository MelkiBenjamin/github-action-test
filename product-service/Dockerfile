FROM rust:1.80.1 AS builder

RUN USER=root cargo new --bin product-service

# Create a new directory for our application
WORKDIR /product-service

# Set the build argument for the app version number
ARG APP_VERSION=0.1.0

# Copy the source files to the container
ADD . ./

# install lib musl optimised for small binary size and timing
#RUN apt install -y musl-tools 
RUN apt update && apt install -y musl-tools musl-dev
RUN update-ca-certificates

#Build the application with libc musl for fast and small binary size and timing and parallelism
RUN cargo build --release --target x86_64-unknown-linux-musl

# Create a new stage and copy the binary from the builder stage busybox with glibc
FROM scratch AS app
WORKDIR /app

# Set the build argument for the app version number
ARG APP_VERSION=0.1.0

# Copy the binary from the builder stage
COPY --from=builder /product-service/target/x86_64-unknown-linux-musl/release/product-service .

# Set the environment variable for the app version number
ENV APP_VERSION=$APP_VERSION

# Run the application
CMD ["./product-service"]
