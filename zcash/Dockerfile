FROM ubuntu:16.04

WORKDIR /root

RUN apt-get update && \
    apt-get install -y \
    wget unzip curl nano\
    build-essential pkg-config libc6-dev m4 g++-multilib \
    autoconf libtool ncurses-dev unzip git python python-zmq \
    zlib1g-dev wget curl bsdmainutils automake

RUN wget https://github.com/zcash/zcash/archive/v2.0.5-2.tar.gz \
  && tar -zxvf v2.0.5-2.tar.gz \
  && cd zcash-2.0.5-2 \
  && ./zcutil/fetch-params.sh \
  && ./zcutil/build.sh -j$(nproc)
  
RUN mkdir -p ~/.zcash \
    && echo "addnode=mainnet.z.cash" >~/.zcash/zcash.conf   

RUN cp ./zcash-2.0.5-2/src/zcashd /usr/bin

cmd zcashd

volume ./data:/root/.zcash/

EXPOSE 8233, 8232
