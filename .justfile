user := env_var_or_default('USERNAME', 'user')
bare_image_name := user + '_kali_bare'
headless_image_name := user + '_kali_headless'
setup_container_name := 'kali_setup'
active_container_name := user + '_kali'

# Defaults to the "run" command
default: run

# Run first-time setup
@setup:
    echo 'Setup will require root permissions to modify /usr/local/bin.'
    sudo ln -s "$(pwd)"/kalidocker /usr/local/bin/kalidocker
    echo 'KaliDocker has been successfully set up! You may now execute "kalidocker" anywhere on your system'

# Build the setup image
build:
    docker build --build-arg USERNAME={{user}} --tag {{bare_image_name}} .

# Build the setup image without using any build cache
build-clean:
    docker build --no-cache --build-arg USERNAME={{user}} --tag {{bare_image_name}} .

# Installs Kali CLI tools
install:
    docker run -it --name {{setup_container_name}} {{bare_image_name}} ./install.sh
    docker commit --change 'CMD []' {{setup_container_name}} {{headless_image_name}}
    docker rm {{setup_container_name}}
    @echo $(tput setaf 2) [+] KALI DOCKER INSTALL COMPLETE $(tput setaf 7)

# Update the headless image with changes from the active container
update-image:
    docker commit {{active_container_name}} {{headless_image_name}}

# Update the headless image with changes from a specific container
update-image-custom CONTAINER:
    docker commit {{CONTAINER}} {{headless_image_name}}

# Runs a bash shell in a Kali Linux container!
run:
    -docker run --rm -it \
        -v "$(pwd)"/kali:/home/{{user}} \
        --hostname {{active_container_name}} \
        --name {{active_container_name}} \
        {{headless_image_name}}

# Runs a Kali container with a custom name
run-custom NAME:
    -docker run --rm -it \
        -v "$(pwd)"/kali:/home/{{user}} \
        --hostname {{NAME}} \
        --name {{NAME}} \
        {{headless_image_name}}
