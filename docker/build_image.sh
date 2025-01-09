#!/bin/bash

# Get the current username
USERNAME=$(whoami)
USER_UID=$(id -u)

# Define the docker image name
IMAGE_NAME="gen6d_image_$USERNAME"

# Build the Docker image
docker build -t $IMAGE_NAME --build-arg USERNAME=$USERNAME --build-arg USER_UID=$USER_UID .

# Print a success message
echo "Docker image '$IMAGE_NAME' built successfully."