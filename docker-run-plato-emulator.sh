#!/bin/sh
docker run --rm -it \
           --volume $(pwd):/usr/src/plato \
           --volume "${HOME}/.Xauthority:/root/.Xauthority" \
           --volume /tmp/.X11-unix:/tmp/.X11-unix \
           --volume /dev/shm:/dev/shm \
           --env DISPLAY=unix${DISPLAY} \
           --env XDG_RUNTIME_DIR \
           --device /dev/dri \
           --net=host \
           local-plato-emulator:latest
