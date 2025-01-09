#!/bin/bash

# Get the current username
USERNAME=$(whoami)

# Define the container name
CONTAINER_NAME="gen6d_container_$USERNAME"

# Define the image name
IMAGE_NAME="gen6d_image_$USERNAME"

# get parent directory
PARENT_DIR=$(dirname $(pwd))

# data directory
DATA_DIR=/media/HDD1/Edgar_Data/Models/Gen6D/data/

if [ "$(docker ps -aq -f status=exited -f name=$CONTAINER_NAME)" ]; then
    echo "Container $CONTAINER_NAME already exists but is stopped. Starting it"
    docker start $CONTAINER_NAME
elif [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Container $CONTAINER_NAME already exists. Opening a bash terminal inside it."
    docker exec -it $CONTAINER_NAME /bin/bash
else
    echo "Container $CONTAINER_NAME does not exist. Creating it and starting it."
    # Run the container and open a bash terminal inside it
    docker run \
        -e QT_XCB_GL_INTEGRATION=xcb_egl \
        -e DISPLAY=$DISPLAY \
        -w /home/$USERNAME/GEN6D \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v $PARENT_DIR:/home/$USERNAME/GEN6D \
        -v $DATA_DIR:$DATA_DIR \
        --gpus all \
        --privileged \
        -it --name $CONTAINER_NAME $IMAGE_NAME /bin/bash
fi