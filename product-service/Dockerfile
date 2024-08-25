FROM rust:alpine3.20 AS builder

RUN USER=root cargo new --bin product-service

# Create a new directory for our application
WORKDIR /product-service

# Set the build argument for the app version number
ARG APP_VERSION=0.1.0

# Copy the source files to the container
ADD . ./

# install lib musl with Build the application with libc musl for fast
RUN apk add musl-dev
RUN cargo build --release --target x86_64-unknown-linux-musl 

# Create a new stage and copy the binary from the builder stage busybox with glibc
FROM busybox:musl AS app
WORKDIR /app

# Set the build argument for the app version number
ARG APP_VERSION=0.1.0

# Not ideal but needed to execute health checks in docker-compose
#RUN apt-get update && apt-get install -y wget

# Copy the binary from the builder stage
COPY --from=builder /product-service/target/x86_64-unknown-linux-musl/release/product-service /app
#COPY --from=builder /product-service/target/release/product-service /app

# Copy the libssl 3 ici
#COPY --from=caddy:2.7 /lib/libssl.so.3 /lib/libssl.so.3
#COPY --from=caddy:2.7 /lib/libcrypto.so.3 /lib/libcrypto.so.3

# copy libgcc_s.so.1
#COPY --from=builder /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/x86_64-linux-gnu/libgcc_s.so.1

# Copy the sh ici
#COPY --from=caddy:2.7 /bin/sh /bin/sh

# Set the environment variable for the app version number
ENV APP_VERSION=$APP_VERSION

# Run the application
#CMD ["./product-service"]
