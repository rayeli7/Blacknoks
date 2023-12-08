# Use the latest Ubuntu image as the base for our container.
FROM ubuntu:latest

# Update and install necessary dependencies for building the Flutter app.
RUN apt-get update && apt-get install -y git curl wget unzip

# Download the Flutter SDK archive.
RUN curl -o flutter.tar.gz https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_x64.tar.gz
# Extract the Flutter SDK archive to the /opt directory.
RUN tar -xf flutter.tar.gz -C /opt
# Remove the downloaded archive to save space in the image.
RUN rm flutter.tar.gz

# Add the Flutter bin directory to the PATH environment variable.
ENV PATH="/opt/flutter/bin:${PATH}"

# Set the working directory for the container to the /app directory.
WORKDIR /Blacknoks

# Copy all files from the current directory (where the Dockerfile resides) to the container's working directory. This includes the Flutter app source code.
COPY . .

# Install all Flutter dependencies for the app using the `pub get` command.
RUN flutter pub get

# Build the Flutter app for the web platform. 
RUN flutter build web
