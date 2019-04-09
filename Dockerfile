FROM ubuntu:xenial
MAINTAINER Drazen Urch <github@drazenur.ch>

ENV USER root
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    software-properties-common \
    python-software-properties \
    wget
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -  && \
    add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        musl-tools \
        clang \
        libclang-dev \
        git \
        libssl-dev \
        bc

ARG RUST_VER=1.33.0
RUN curl -sO https://static.rust-lang.org/dist/rust-${RUST_VER}-x86_64-unknown-linux-gnu.tar.gz && \
    tar -xzf rust-${RUST_VER}-x86_64-unknown-linux-gnu.tar.gz && \
    ./rust-${RUST_VER}-x86_64-unknown-linux-gnu/install.sh --without=rust-docs && \
    curl -sO https://static.rust-lang.org/dist/rust-std-${RUST_VER}-x86_64-unknown-linux-musl.tar.gz && \
    tar -xzf rust-std-${RUST_VER}-x86_64-unknown-linux-musl.tar.gz && \
    ./rust-std-${RUST_VER}-x86_64-unknown-linux-musl/install.sh --without=rust-docs
RUN cargo install bindgen

ARG PG_VER=10
RUN apt-get install -y --no-install-recommends postgresql-server-dev-${PG_VER} && \
    apt-get remove --purge -y curl && \
    apt-get autoremove -y
RUN rm -rf \
    rust-std-${RUST_VER}-x86_64-unknown-linux-musl \
    rust-${RUST_VER}-x86_64-unknown-linux-gnu \
    rust-std-${RUST_VER}-x86_64-unknown-linux-musl.tar.gz \
    rust-${RUST_VER}-x86_64-unknown-linux-gnu.tar.gz \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*
