#!/bin/sh
docker build --target=builder \
             --progress=plain \
             --tag plato-builder .

