#!/bin/bash

# Get the current username
USERNAME=$(whoami)

# Define the container name
CONTAINER_NAME="gen6d_container_$USERNAME"

# Stop the container
docker stop $CONTAINER_NAME