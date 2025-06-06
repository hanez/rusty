# My Rust environment in a Docker container

    sudo su -
    cd /home
    git clone https://git.xw3.org/hanez/rust-docker
    or
    git clone git@git.xw3.org:hanez/rust-docker.git
    cd rust-docker
    docker build -t rusty .
    docker run -it --entrypoint /bin/bash rusty
 
