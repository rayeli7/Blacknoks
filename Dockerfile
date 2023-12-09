# Use the latest Ubuntu image as the base for our container.
FROM ubuntu:latest

# Update and install necessary dependencies for building the Flutter app.
RUN apt-get update && apt-get install -y git curl wget unzip xz-utils zip libglu1-mesa mesa-libGLU

# Download the Flutter SDK archive with wget.
ENV FLUTTER_VERSION 3.16.3  # Specify desired Flutter SDK version
RUN wget -O flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$FLUTTER_VERSION-stable.tar.xz

# Extract the Flutter SDK archive to the /opt directory.
RUN tar -xf flutter.tar.xz -C /opt

# Remove the downloaded archive to save space in the image.
RUN rm flutter.tar.xz

# Add the Flutter bin directory to the PATH environment variable.
ENV PATH="/opt/flutter/bin:${PATH}"

# Fix "dubious ownership" issue in the Flutter directory
RUN git config --global --add safe.directory /opt/flutter

# Clean the existing Pub cache
RUN dart pub cache clean

# Set the working directory for the container to the /app directory.
WORKDIR /app

# Copy all files from the current directory (where the Dockerfile resides) to the container's working directory. This includes the Flutter app source code.
COPY . .

# Install all Flutter dependencies for the app using the `pub get` command.
RUN flutter pub get

# Build the Flutter app for the web platform. 
RUN flutter build web
