FROM rust:latest
WORKDIR /home/rust-docker
#COPY . .

RUN apt update -y
RUN apt install -y apt-utils bash git mc protobuf-compiler vim
RUN apt dist-upgrade -y

RUN git clone --branch v0.7.1 --single-branch https://github.com/boxdot/gurk-rs.git gurk
RUN cargo build --manifest-path /home/rust-docker/gurk/Cargo.toml --profile release
RUN cp /home/rust-docker/gurk/target/release/gurk /usr/bin/

RUN git clone --branch 25.01.1 --single-branch https://github.com/helix-editor/helix.git helix
RUN cargo build --manifest-path /home/rust-docker/helix/Cargo.toml --profile release
RUN cp /home/rust-docker/helix/target/release/hx /usr/bin/

ENTRYPOINT ["bash"]

