#!/bin/sh
docker build --target gcc-stage \
             --file slim.Dockerfile \
             --tag gcc-linaro-slim \
             --progress plain \
             .
