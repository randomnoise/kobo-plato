#!/bin/sh

# --volume /tmp/.X11-unix:/tmp/.X11-unix
# --volume /dev/shm:/dev/shm
# --env XDG_RUNTIME_DIR

# echo "Incoming parameters to this script: \""$@"\"";
docker run --rm --interactive --tty \
           --volume $(pwd):/usr/src/plato \
           plato-builder
