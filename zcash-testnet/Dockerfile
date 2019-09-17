FROM ubuntu:16.04

WORKDIR /root

RUN apt-get update && \
    apt-get install -y \
    wget unzip curl nano\
    build-essential pkg-config libc6-dev m4 g++-multilib \
    autoconf libtool ncurses-dev unzip git python python-zmq \
    zlib1g-dev wget curl bsdmainutils automake

RUN wget https://github.com/zcash/zcash/archive/v2.0.0.tar.gz \
  && tar -zxvf v2.0.0.tar.gz \
  && cd zcash-2.0.0\
  && ./zcutil/fetch-params.sh --testnet \
  && ./zcutil/build.sh -j$(nproc)
  
RUN mkdir -p ~/.zcash \
    && echo "addnode=testnet.z.cash" >~/.zcash/zcash.conf \
    && echo "testnet=1" >> ~/.zcash/zcash.conf

RUN cp ./zcash-2.0.0/src/zcashd /usr/bin

cmd zcashd

volume ./data:/root/.zcash/
