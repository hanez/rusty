FROM alpine:3.22

ENV \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.87.0 \
    RUSTUP_HOME=/usr/local/rustup \
    TZ="Europe/Berlin"

WORKDIR /root

# Do this because next steps require some software packages to be installed
RUN apk add --no-cache alpine-sdk ca-certificates perl

# Install Rust (Copied from the official Rust Dockerfile)
RUN \
    set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
        x86_64) rustArch='x86_64-unknown-linux-musl'; rustupSha256='e6599a1c7be58a2d8eaca66a80e0dc006d87bbcf780a58b7343d6e14c1605cb2' ;; \
        aarch64) rustArch='aarch64-unknown-linux-musl'; rustupSha256='a97c8f56d7462908695348dd8c71ea6740c138ce303715793a690503a94fc9a9' ;; \
        *) echo >&2 "unsupported architecture: $apkArch"; exit 1 ;; \
    esac; \
    url="https://static.rust-lang.org/rustup/archive/1.28.2/${rustArch}/rustup-init"; \
    wget "$url"; \
    echo "${rustupSha256} *rustup-init" | sha256sum -c -; \
    chmod +x rustup-init; \
    ./rustup-init -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION --default-host ${rustArch}; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;

# Install Rust based applications
# ...

# Setup environment
RUN \
    apk update; \
    apk upgrade --available; \
    apk add --no-cache bash byobu helix mc openssh shadow tmux vim zsh zsh-vcs neovim

RUN \
    chsh -s /bin/zsh root; \
    useradd -M -u 1000 -U -s /bin/zsh -d /home/hanez hanez; \
    useradd -M -u 1001 -U -s /bin/bash -d /home/one one; \
    useradd -M -u 1002 -U -s /bin/ash -d /home/two two

# This is obsolete since I use docker-compose for managing the container
ENTRYPOINT ["bash"]

