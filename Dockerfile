FROM kalilinux/kali-rolling:latest

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

RUN sudo apt update && sudo apt -y install -d kali-linux-headless

WORKDIR /home/$USERNAME

COPY scripts/install.sh /home/$USERNAME/install.sh

RUN chmod +x /home/$USERNAME/install.sh

ENTRYPOINT ["/bin/bash"]