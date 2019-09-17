FROM base/archlinux:latest

WORKDIR /root

RUN echo "Install essentials" && \
    pacman -Syyu --noconfirm nodejs npm make gcc git python python2

RUN echo "Install NVIDIA drivers & cuda" && \
    pacman -S --noconfirm nvidia nvidia-utils nvidia-settings cuda

RUN echo "Rock & Roll" && \
    npm install hs-miner

volume ./data:/root/.hsd-mine/
