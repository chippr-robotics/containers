FROM ubuntu:16.04

WORKDIR /root

RUN echo "Updating system" \
    && apt-get update  \
    && apt-get install -y \
       wget unzip curl nano\
       build-essential pkg-config libc6-dev m4 g++-multilib \
       autoconf libtool ncurses-dev unzip git python python-zmq \
       zlib1g-dev wget curl bsdmainutils automake

RUN echo "Installing Tor & nyx" \
  && touch /etc/apt/sources.list.d/torproject.list \
  && echo "deb http://deb.torproject.org/torproject.org xenial main" >  /etc/apt/sources.list.d/torproject.list \
  && gpg --keyserver keys.gnupg.net --recv 0x886DDD89 \
  && gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add - \
  && apt-get update \
  && apt-get install -y tor deb.torproject.org-keyring tor-geoipdb apparmor-utils torsocks

RUN echo " Creating Tor config file" \
  && rm /etc/tor/torrc \
  && echo "ClientOnly 1    \n \
SOCKSPort 9050    \n \
SOCKSPolicy accept 127.0.0.1/0  \n \
Log notice file /var/log/tor/notices.log \n \
ControlPort 9051  \n \
HiddenServiceStatistics 0 \n \
ORPort 9001  \n \
LongLivedPorts 21,22,706,1863,5050,5190,5222,5223,6523,6667,6697,8300,8233 \n \
DisableDebuggerAttachment 0 " > /etc/tor/torrc

RUN echo "Installing Bitcoin" \
  &&  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C70EF1F0305A1ADB9986DBD8D46F45428842CE5E \
  && echo "deb http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu xenial main" > /etc/apt/sources.list.d/bitcoin.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends bitcoind 

cmd bitcoind

volume ./data:/root/.bitcoin/
