#!/bin/sh
docker run --rm -it \
           --volume $(pwd):/usr/src/plato \
           local-plato-builder:latest
