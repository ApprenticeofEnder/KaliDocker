# KaliDocker

> I got fed up with VMs, I got fed up with USBs, and I didn't want to install to bare metal. So I made Kali work for me in Docker.

KaliDocker makes setting up and using the dockerized version of Kali Linux more user-friendly. It comes pre-loaded with everything you might need and then some; if it doesn't, you have an install script at your disposal, too.

```bash
$ kalidocker -h
Available commands:
    build                         # Build the setup image
    b                             # alias for `build`
    build-clean                   # Build the setup image without using any build cache
    default                       # Defaults to the "run" command
    install                       # Installs Kali CLI tools
    i                             # alias for `install`
    run                           # Runs a bash shell in a Kali Linux container!
    r                             # alias for `run`
    run-custom NAME               # Runs a Kali container with a custom name
    rc NAME                       # alias for `run-custom`
    setup                         # Run first-time setup
    update-image                  # Update the headless image with changes from the active container
    u                             # alias for `update-image`
    update-image-custom CONTAINER # Update the headless image with changes from a specific container
    uc CONTAINER                  # alias for `update-image-custom`
```

## Prerequisites

- `just` ([Docs here](https://github.com/casey/just))
- Docker ([Docs here](https://docs.docker.com/engine/install/))

## Setup
In the main script directory, run the following:
```bash
./kalidocker setup
```

This will allow you to run `kalidocker` from anywhere on your system.

## Installation
There are two options to install Kalidocker:
1. Online build, offline install
2. Fully online install

Both options will take a while, so this primarily depends on the speed and time you have access to an internet connection.

Once you see this message, you know it's completed the installation:

```
[+] KALI DOCKER INSTALL COMPLETE
```

### Option 1 - Online Build, Offline Install
This requires the `build` command to be run with an internet connection, while the `install` command can be run without.

```bash
# Build the bare image (requires internet)
kalidocker build
# Alternatively: kalidocker b

# Install tools and commit the updates to a finalized image
# (No internet connection required)
kalidocker install
# Alternatively: kalidocker i
```

### Option 2 - Fully online install
This requires an internet connection the full way through. The `install` command uses `build` internally, so you don't have to run that yourself.

```bash
# Build, install and commit (requires internet)
kalidocker install
# Alternatively: kalidocker i
```

## Usage
Using KaliDocker is about as easy as installing it: 

```bash
# Run the Kali Docker container (all commands are equivalent)
kalidocker
# Alternatively: kalidocker r, kalidocker run

# With a custom name (both commands are equivalent)
kalidocker run-custom <your-container-name>
# Alternatively: kalidocker rc <your-container-name>
```

### The `kali` Directory
That directory named `kali`? That's a bind mount for your home directory. You can add and remove files to it from your host machine, or the container. Easy!

### Installing New Software On Kali
If you find a tool or other bit of software that you like and want to have permanently, you can also update the image after you have installed the new software! Run this on your host machine with an active Kali container:

```bash
# Update the headless image
kalidocker update-image
# Alternatively: kalidocker u

# Update the headless image from a specific container
kalidocker update-image-custom <container-name>
# Alternatively: kalidocker uc <container-name>
```

# Contributing

Not quite ready for contributions just yet (still need to make some measures), but you're free to open issues!

## Temporary code of conduct
1. Don't be a jerk.
2. Overcommunicate.
3. Any harmful or offensive language and/or behaviour will not be tolerated (this follows from 1).

# Documentation
Any further suggestions on documentation can be raised in an issue on this repository.
