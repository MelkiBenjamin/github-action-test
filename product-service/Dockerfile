FROM rust:alpine3.20 AS builder

# install lib musl
RUN USER=root cargo new --bin product-service

# Create a new directory for our application
WORKDIR /product-service

# Set the build argument for the app version number
ARG APP_VERSION=0.1.0

# Copy the source files to the container
COPY . ./ 

#Build the application with libc musl 
RUN apk add --no-cache musl-dev \
  && addgroup -S appgroup && adduser -S benjamin -G appgroup \
  && cargo build --release 

# Create a new stage and copy the binary from the builder stage busybox with glibc
FROM scratch AS app
WORKDIR /app

# Set the build argument for the app version number
ARG APP_VERSION=0.1.0

# Not ideal but needed to execute health checks in docker-compose
#RUN apt-get update && apt-get install -y wget

# Copy the binary from the builder stage
COPY --from=builder /etc/passwd /etc/group /etc/ \
  && --from=builder /product-service/target/release/product-service .
   
USER benjamin

# Set the environment variable for the app version number
ENV APP_VERSION=$APP_VERSION

# Run the application
CMD ["./product-service"]
