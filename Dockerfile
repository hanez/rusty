FROM rust:latest
ENV TZ="Europe/Berlin"
WORKDIR /root

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

RUN apt update -y
RUN apt dist-upgrade -y
RUN apt install -y apt-utils build-essential byobu git mc protobuf-compiler tmux vim zsh

RUN chsh -s /bin/zsh root

RUN useradd -M -u 1000 -U -s /bin/zsh -d /home/hanez hanez
RUN useradd -M -u 1001 -U -s /bin/bash -d /home/test test

ENTRYPOINT ["bash"]

