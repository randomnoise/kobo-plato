# syntax=docker/dockerfile:1
FROM rust:1.76-slim-bookworm AS plato-builder-base

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

RUN rustup target add arm-unknown-linux-gnueabihf
WORKDIR /usr/src/plato


FROM plato-builder-base AS plato-builder-libs

RUN cd /usr/src/ \
 && git clone --depth 1 https://github.com/baskerville/plato.git \
 && git config --global --add safe.directory /usr/src/plato \
 && cd /usr/src/plato/ \
 && ./build.sh


FROM plato-builder-base AS plato-builder

# https://doc.rust-lang.org/cargo/guide/cargo-home.html#caching-the-cargo-home-in-ci
COPY --from=plato-builder-libs $CARGO_HOME/registry/index/ $CARGO_HOME/registry/index/
COPY --from=plato-builder-libs $CARGO_HOME/registry/cache/ $CARGO_HOME/registry/cache/

COPY --from=plato-builder-libs /usr/src/plato/libs/ /usr/src/plato/libs/
COPY --from=plato-builder-libs /usr/src/plato/target/ /usr/src/plato/target/
COPY --from=plato-builder-libs /usr/src/plato/thirdparty/mupdf/ /usr/src/plato/thirdparty/mupdf/
COPY --from=plato-builder-libs /usr/src/plato/plato-0.9.40.zip /usr/src/plato/

COPY . .
