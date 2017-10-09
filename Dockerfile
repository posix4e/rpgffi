FROM ubuntu:xenial
MAINTAINER Drazen Urch <github@drazenur.ch>

ARG PG_VER=10
ARG RUST_VER=1.13.0

ENV USER root

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    software-properties-common \
    python-software-properties \
    wget
RUN add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -  && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        musl-tools \
        clang \
        libclang-dev \
        git \
        libssl-dev \
        bc \
        postgresql-server-dev-${PG_VER}
RUN curl -sO https://static.rust-lang.org/dist/rust-${RUST_VER}-x86_64-unknown-linux-gnu.tar.gz && \
    tar -xzf rust-${RUST_VER}-x86_64-unknown-linux-gnu.tar.gz && \
    ./rust-${RUST_VER}-x86_64-unknown-linux-gnu/install.sh --without=rust-docs && \
    curl -sO https://static.rust-lang.org/dist/rust-std-${RUST_VER}-x86_64-unknown-linux-musl.tar.gz && \
    tar -xzf rust-std-${RUST_VER}-x86_64-unknown-linux-musl.tar.gz && \
    ./rust-std-${RUST_VER}-x86_64-unknown-linux-musl/install.sh --without=rust-docs
RUN cargo install bindgen

RUN DEBIAN_FRONTEND=noninteractive apt-get remove --purge -y curl && \
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y
RUN rm -rf \
    rust-std-${RUST_VER}-x86_64-unknown-linux-musl \
    rust-${RUST_VER}-x86_64-unknown-linux-gnu \
    rust-std-${RUST_VER}-x86_64-unknown-linux-musl.tar.gz \
    rust-${RUST_VER}-x86_64-unknown-linux-gnu.tar.gz \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*
