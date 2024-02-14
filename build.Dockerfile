# syntax=docker/dockerfile:1
FROM rust:1.76-slim-bookworm AS builder

# install dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture armhf \
 && apt-get update \
 && apt-get install --no-install-recommends --yes \
    g++-arm-linux-gnueabihf \
    gcc-arm-linux-gnueabihf \
    git \
    jq \
    patchelf \
    pkg-config \
    unzip \
    wget \
 && rm --recursive --force /var/lib/apt/lists/*

WORKDIR /usr/src/plato
RUN git config --global --add safe.directory /usr/src/plato

RUN rustup target add arm-unknown-linux-gnueabihf
