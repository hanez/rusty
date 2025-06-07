# My Hack environment in a Docker container

The container actually is based on rust:latest which itself is based on Debian (Bookworm). Maybe I will switch to the Debian image, or better switch to an Alpine based image in the future. Actually I prefer the Debian image because it makes it more flexible to me because sometimes I need the GNU libc to compile programs.

Why the name "rusty"? Because it is based on some earlier Docker stuff I made for compiling Rust code... And rusty just sounds cool.

My plan is to switch from Docker to native Linux Containers at some time but I am faster in building the prototype using Docker... ;)

## Get the code

    git clone https://git.xw3.org/hanez/rusty
    # or
    git clone git@git.xw3.org:hanez/rusty.git (needs an account on git.xw3.org)
    cd rusty

## Prepare environment

    mkdir -p home/$USER
    chown $USER:$USER home/$USER
    su
    # or 
    sudo su
    chown root:root home
    mkdir root
    chown root:root root

## Configure your environment (Optional)

Optionally you can configure your $HOME directories. I do this by pulling my $HOME config from my Git server. E.g.:

    cd home/hanez
    git clone git@git.xw3.org:hanez/home.git
    cd ../..
    su
    # or
    sudo su
    cd root
    git clone git@git.xw3.org:hanez/home.git
    cd ..

## Using docker compose

    docker compose build
    docker compose up -d
    docker attach rusty 

## Using the Dockerfile only (less comfortable and without shared directories)

I recommend not to do it this way! You have been warned!

    docker build -t rusty .
    docker run -it --entrypoint /bin/bash rusty

