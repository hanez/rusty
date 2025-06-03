FROM rust:latest
WORKDIR /opt/rust
COPY . .

RUN apt update -y && apt dist-upgrade -y
RUN apt install -y bash git protobuf-compiler vim

RUN git clone --branch v0.7.1 --single-branch https://github.com/boxdot/gurk-rs.git gurk
RUN cargo build --manifest-path /opt/rust/gurk/Cargo.toml
RUN cp /opt/rust/gurk/target/debug/gurk /usr/bin/

RUN git clone --branch 25.01.1 --single-branch https://github.com/helix-editor/helix.git helix
RUN cargo build --manifest-path /opt/rust/helix/Cargo.toml
RUN cp /opt/rust/helix/target/debug/helix /usr/bin/

#RUN cargo build
#RUN cargo install --git https://github.com/boxdot/gurk-rs gurk
#RUN cargo install --path .
#CMD ["gurk" ]
#CMD ["bash" ]
ENTRYPOINT ["bash"]
