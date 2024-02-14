# syntax=docker/dockerfile:1
FROM rust:1.76-bookworm AS gcc-stage

ADD https://releases.linaro.org/components/toolchain/binaries/4.9-2017.01/arm-linux-gnueabihf/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf.tar.xz /
RUN tar Jxf gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf.tar.xz

FROM rust:1.76-bookworm AS builder

# add arm-linux-gnueabihf-gcc
COPY --from=gcc-stage /gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf /gcc-linaro
ENV PATH=/gcc-linaro/bin:$PATH

# install dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update --quiet \
 && apt-get install --no-install-recommends --yes --quiet \
    curl \
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

FROM builder AS emulator

# install dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update --quiet \
 && apt-get install --no-install-recommends --yes --quiet \
    libfreetype6 \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libsdl2-2.0-0 \
    libsdl2-dev \
    libmupdf-dev \
    libgumbo-dev \
    libharfbuzz-dev \
    libjbig2dec0-dev \
    mupdf \
 && rm --recursive --force /var/lib/apt/lists/*

FROM emulator AS emulator-dev

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update --quiet \
 &&  apt-get install --no-install-recommends --yes --quiet \
    strace \
    ltrace \
    mupdf-tools \
&& rm --recursive --force /var/lib/apt/lists/*
