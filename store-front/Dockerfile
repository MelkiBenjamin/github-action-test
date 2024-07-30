# Use an official Node.js runtime as a parent image
FROM node:18.16.0-alpine AS builder

WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Create user
# Create a group and user
RUN addgroup -S appgroup && adduser -S benjamin -G appgroup

# Tell docker that all future commands should run as the appuser user
#USER benjamin

# Install app dependencies
RUN npm install --ignore-scripts

# Copy the rest of the app source code to the container
COPY . .

# Build the app
RUN npm run build 

# Run the app on nginx from alpine-slim
FROM nginx:stable-alpine-slim AS runner

# COPY user from builder to alpine-slim
COPY --from=builder /etc/passwd /etc/group /etc/
USER benjamin

# Copy the build output to replace the default nginx contents
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose the port the app listens on
EXPOSE 8080

# Set the build argument for the app version number
ARG APP_VERSION=0.1.0

# Set the environment variable for the app version number
ENV APP_VERSION=$APP_VERSION

# Copy the nginx configuration template to the container
COPY nginx.conf /etc/nginx/conf.d/nginx.conf.template

# Update the nginx configuration to use the app version number
# and Copy the nginx configuration template to the container
RUN envsubst '${APP_VERSION}' < /etc/nginx/conf.d/nginx.conf.template > /etc/nginx/conf.d/default.conf

# Start the app
CMD ["nginx", "-g", "daemon off;"]