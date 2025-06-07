FROM alpine:3.22
#FROM rust:latest
ENV TZ="Europe/Berlin"
WORKDIR /root

RUN apk add --no-cache alpine-sdk ca-certificates

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.87.0

RUN set -eux; \
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

#RUN git clone --branch v1.1.0 --single-branch https://github.com/microsoft/edit.git edit
#RUN cargo build --manifest-path /home/rust-docker/edit/Cargo.toml --profile dev
#RUN cp /home/rust-docker/edit/target/release/edit /usr/bin/

#RUN git clone --branch v0.7.1 --single-branch https://github.com/boxdot/gurk-rs.git gurk
#RUN cargo build --manifest-path /home/rust-docker/gurk/Cargo.toml --profile release
#RUN cp /home/rust-docker/gurk/target/release/gurk /usr/bin/

RUN git clone --branch 25.01.1 --single-branch https://github.com/helix-editor/helix.git helix
RUN cargo build --manifest-path /root/helix/Cargo.toml --profile release
RUN cp /root/helix/target/release/hx /usr/bin/

#RUN git clone --branch v1.0.0 --single-branch https://github.com/FedericoBruzzone/tgt.git tgt
#RUN cargo build --manifest-path /home/rust-docker/tgt/Cargo.toml --profile release --features download-tdlib
#RUN cp /home/rust-docker/tgt/target/release/tgt /usr/bin/

RUN apk update
RUN apk upgrade --available
RUN apk add --no-cache bash mc openssh shadow tmux vim zsh zsh-vcs neovim

#RUN apt update -y
#RUN apt dist-upgrade -y
#RUN apt install -y apt-utils build-essential byobu git mc protobuf-compiler tmux vim zsh

RUN chsh -s /bin/zsh root
RUN useradd -M -u 1000 -U -s /bin/zsh -d /home/hanez hanez
RUN useradd -M -u 1001 -U -s /bin/bash -d /home/test test

ENTRYPOINT ["bash"]

