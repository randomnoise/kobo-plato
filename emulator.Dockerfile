# syntax=docker/dockerfile:1
FROM rust:1.76-bookworm AS emulator

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && apt-get install --no-install-recommends --yes \
    jq \
    libdjvulibre-dev \
    libgumbo-dev \
    libharfbuzz-dev \
    libjbig2dec0-dev \
    libsdl2-dev \
    libtool \
    patch \
    pkg-config \
    unzip \
    wget \
    # MuPDF depencendies
    libglu1-mesa-dev \
    freeglut3-dev \
    mesa-common-dev \
 && rm --recursive --force /var/lib/apt/lists/*

RUN cd /tmp \
 && wget -q "https://mupdf.com/downloads/archive/mupdf-1.23.6-source.tar.gz" -O - | tar -xz \
 && cd /tmp/mupdf-1.23.6-source \
 && make build=release libs apps \
 && make build=release prefix=usr install \
 && find usr/include usr/share usr/lib -type f -exec chmod 0644 {} + \
 && cp -r usr/* /usr/

ENV CARGO_TARGET_OS=linux

WORKDIR /usr/src/plato

# CMD ["bash", "-c", "cd /plato/src/mupdf_wrapper && ./build.sh && cd /plato/ && cargo test && cargo build --all-features"]
