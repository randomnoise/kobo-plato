#!/bin/sh
docker run --rm -it \
           --volume $(pwd)/dist:/usr/src/plato/dist \
           local-plato-builder:latest
