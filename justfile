user := env_var_or_default('USERNAME', 'user')
bare_image_name := user + '_kali_bare'
headless_image_name := user + '_kali_headless'
setup_container_name := 'kali_setup'
active_container_name := user + '_kali'

# Build the setup image
build:
    docker build --build-arg USERNAME={{user}} --tag {{bare_image_name}} .

# Build the setup image without using any build cache
build-clean:
    docker build --no-cache --build-arg USERNAME={{user}} --tag {{bare_image_name}} .

# Installs Kali CLI tools (2 hour grace period to commit)
install:
    docker run --rm -it --name {{setup_container_name}} {{bare_image_name}} ./install.sh \
        && echo $(tput setaf 2) [+] KALI DOCKER INSTALL COMPLETE $(tput setaf 7) \
        && sleep 7200

# Commit the installation to a Kali image
commit:
    docker commit {{setup_container_name}} {{headless_image_name}}

# Update the headless image with changes from the active container
update-image:
    docker commit {{active_container_name}} {{headless_image_name}}

# Runs a bash shell in a Kali Linux container!
run:
    docker run --rm -it -v "$(pwd)"/kali:/home/{{user}} {{headless_image_name}}