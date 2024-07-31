FROM rust:1.80.0 AS builder

RUN USER=root cargo new --bin product-service

# Create a new directory for our application
WORKDIR /product-service

# Set the build argument for the app version number
ARG APP_VERSION=0.1.0

# Copy the source files to the container
ADD . ./

# Installer les outils nécessaires
RUN apt-get update && apt-get install -y \
    musl-tools \
    && rm -rf /var/lib/apt/lists/*

# Installer la cible musl
RUN rustup target add x86_64-unknown-linux-musl

# Build the application
RUN cargo build --release --target x86_64-unknown-linux-musl

# Create a new stage and copy the binary from the builder stage
FROM alpine:3.20.2 AS runner
WORKDIR /app

# Set the build argument for the app version number
ARG APP_VERSION=0.1.0

# Not ideal but needed to execute health checks in docker-compose
#RUN apt-get update && apt-get install -y wget
#RUN apk update && apk add --no-cache gcompat libstdc++

# Copy the binary from the builder stage
COPY --from=builder /product-service/target/release/product-service /app

# Set the environment variable for the app version number
ENV APP_VERSION=$APP_VERSION

# Run the application
#CMD ["./product-service"]
