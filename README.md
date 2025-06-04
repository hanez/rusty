# My Rust environment in a Docker container

    sudo su -
    cd /home
    git clone https://github.com/hanez/rust-docker.git
    or
    git clone git@github.com:hanez/rust-docker.git
    cd rust-docker
    docker build -t rusty .
    docker run -it --entrypoint /bin/bash rusty
 
