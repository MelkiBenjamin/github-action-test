# Use an official Node.js runtime as a parent image
FROM node:slim AS builder

# Set the working directory to /app
WORKDIR /app

# Set the build argument for the app version number
ARG APP_VERSION=0.1.0

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install app dependencies
#RUN npm install --production

# Copy the rest of the app source code to the container
COPY . .

# Expose the port the app listens on
EXPOSE 3000

# Create a group and user
#RUN addgroup -S appgroup && adduser -S benjamin -G appgroup

# Set the environment variable for the app version number
ENV APP_VERSION=$APP_VERSION

# install pkg for building
RUN npm install -g pkg

# Build the app with pkg with compression
RUN pkg package.json --target node18-alpine-x64 --output order-service --compress GZIP

#FROM alpine:latest AS production

# Copy the app from the builder stage
#WORKDIR /app
#COPY --from=builder /app/order-service .

# COPY user from builder to alpine-slim
#COPY --from=builder /etc/passwd /etc/group /etc/
#USER benjamin

CMD ["./order-service"]

# Start the app
#CMD [ "npm", "start" ]