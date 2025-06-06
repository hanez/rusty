# My Hack environment in a Docker container

The container actually is based on rust:latest which itself is based on Debian (Bookworm). Maybe I will switch to the Debian image, or better switch to an Alpine based image in the future. Actually I prefer the Debian image because it makes it more flexible to me because sometimes I need the GNU libc to compile programs.

Why the name "rusty"? Because it is based on some earlier Docker stuff I made for compiling Rust code... And rusty just sounds cool.

My plan is to switch from Docker to native Linux Containers at some time but I am faster in building the prototype using Docker... ;)

## Get the code

    git clone https://git.xw3.org/hanez/rusty
    or
    git clone git@git.xw3.org:hanez/rusty.git
    cd rusty

## Using docker compose

    docker compose build
    docker compose up -d
    docker attach rusty 

## Using the Dockerfile only (less comfortable and without shared directories)

    docker build -t rusty .
    docker run -it --entrypoint /bin/bash rusty
 
