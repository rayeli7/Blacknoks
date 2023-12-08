# Use Ubuntu image as the base
FROM ubuntu:latest

# Install necessary dependencies
RUN apt-get update && apt-get install -y git curl wget unzip

# Download Flutter SDK
RUN curl -o flutter.tar.gz https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_x64.tar.gz
RUN tar -xf flutter.tar.gz -C /opt
RUN rm flutter.tar.gz

# Set environment variable for Flutter path
ENV PATH="/opt/flutter/bin:${PATH}"

# Set working directory to the app directory
WORKDIR /app

# Copy all files from current directory to the container's working directory
COPY . .

# Install Flutter dependencies
RUN flutter pub get

# Build the Flutter app for web platform
RUN flutter build web

