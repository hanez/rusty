# My Hack Environment in a Docker Container

This container image is based on "alpine:3.22".

Why Alpine? Because Alpine Linux is definitely the best Linux based operating system distribution I ever have used since 1999!

Why the name "rusty"? Because it is based on some earlier Docker stuff I made for compiling Rust code... And rusty just sounds cool.

It still includes a full Rust environment/SDK! You need to add "/usr/local/cargo/bin" to your $PATH if you want to make use of it; For user "root" it is done by Docker.

Why Rust? Because I really like this language...

My plan is to switch from Docker to native Linux Containers at some time but I am faster in building the prototype using Docker... ;)

## Prerequisites

 * Docker...! What a wonder... :)
 * Be sure to be a member of the docker group. Else you need to do all the next steps as user root. I will not cover this here!

## Get the code

    git clone https://git.xw3.org/hanez/rusty
    # or
    git clone git@git.xw3.org:hanez/rusty.git # (needs an account on git.xw3.org)
    cd rusty

## Prepare the environment

    mkdir -p home/$USER
    chown $USER:$USER home/$USER
    chmod 0750 home/$USER
    sudo chown root:root home
    sudo mkdir root
    sudo chown root:root root

## Configure your environment (Optional)

Optionally you can configure your $HOME directories (/home/$USER and /root). I do this by pulling my $HOME configuration from my Git server. Pulling my $HOME configuration will not work for you because you are not allowed to pull via the Git protocol. This is just an example on how I do it... E.g.:

    git clone git@git.xw3.org:hanez/home.git home/hanez
    sudo git clone git@git.xw3.org:hanez/home.git root

I manage these Git based $HOME directories/repositories outside of the container.

If you do not configure your $HOME directories here, the container creates missing configuration files.

### Create SSH key file

Create a private key without a password.

    ssh-keygen -N "" -f home/$USER/.ssh/id_rsa

## Using docker compose

    docker compose build
    docker compose up -d
    docker attach rusty

You can stop the container by executing "exit" or by hiting ctrl+c when attached. You can always detache the container when hiting ctrl+p and then ctrl+q. This is useful if you have a screen or a tmux session runningin your container, or maybe some other applications.

