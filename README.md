# KaliDocker

> I got fed up with VMs, I got fed up with USBs, and I didn't want to install to bare metal. So I made Kali work for me in Docker.

KaliDocker makes setting up and using the dockerized version of Kali Linux more user-friendly. It comes pre-loaded with everything you might need and then some; if it doesn't, you have an install script at your disposal, too.

Using `just` for management makes everything ten times easier.

```bash
just -l
Available recipes:
    build        # Build the setup image
    build-clean  # Build the setup image without using any build cache
    commit       # Commit the installation to a Kali image
    install      # Installs Kali CLI tools (2 hour grace period to commit)
    run          # Runs a bash shell in a Kali Linux container!
    update-image # Update the headless image with changes from the active container
```

## Prerequisites

- `just` ([Docs here](https://github.com/casey/just))
- Docker ([Docs here](https://docs.docker.com/engine/install/))

## Installation
It's only a 2-step process!
1. Build
2. Install and Commit

### Step 1 - Build

First, build the image. Fairly straightforward stuff!

```bash
# Build the bare image
just build
```

If you messed something up during the process, there's a fresh build command, too:

```bash
# Build the bare image with a clean start
just build-clean
```

### Step 2 - Install and Commit

This next step might take a bit, so come back in an hour after you've run the command (but don't walk away yet, there's an important bit after this).

```bash
# Install Kali tools
just install
```

Open up another terminal on your host machine, and once you see this in the tab where you ran `just install`, you know it's completed the installation:

```bash
[+] KALI DOCKER INSTALL COMPLETE
```

In that second terminal, be ready to run the following command when the install completes:

```bash
# Commit the installation to the full image
just commit
```

In summary:
- Open up 2 terminal windows/tabs
- Run `just install` on the first
- Run `just commit` on the second when the installation completes

## Usage
Using KaliDocker is even easier than installing it: 

```bash
# Run the Kali Docker container
just run
```

### The `kali` Directory
That directory named `kali`? That's a bind mount for your home directory. You can add and remove files to it from your host machine, or the container. Easy!

### Installing New Software On Kali
If you find a tool or other bit of software that you like and want to have permanently, you can also update the image after you have installed the new software! Run this on your host machine with an active Kali container:

```bash
# Update the headless image
just update-image
```

# Contributing

Not quite ready for contributions just yet (still need to make some measures), but you're free to open issues!

## Temporary code of conduct
1. Don't be a jerk.
2. Overcommunicate.
3. Any harmful or offensive language and/or behaviour will not be tolerated (this follows from 1).

# Documentation
Any further suggestions on documentation can be raised in an issue on this repository.