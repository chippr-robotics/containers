FROM ubuntu:16.04

WORKDIR /root

RUN echo " Updating system" \
    && apt-get update  \
    && apt-get install -y \
       wget unzip curl nano\
       build-essential pkg-config libc6-dev m4 g++-multilib \
       autoconf libtool ncurses-dev unzip git python python-zmq \
       zlib1g-dev logrotate wget curl bsdmainutils automake

RUN echo "Installing Tor & nyx" \
  && touch /etc/apt/sources.list.d/torproject.list \
  && echo "deb http://deb.torproject.org/torproject.org xenial main" >  /etc/apt/sources.list.d/torproject.list \
  && curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import \
#  && gpg --keyserver keys.gnupg.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 \
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

RUN systemctl enable tor
RUN service tor start 

RUN echo "Installing Zcash" \
  && wget https://github.com/zcash/zcash/archive/v2.0.7.tar.gz \
  && tar -zxvf v2.0.7.tar.gz \
  && cd zcash-2.0.7 \
  && ./zcutil/fetch-params.sh \
  && ./zcutil/build.sh -j$(nproc)

RUN echo " Making zcash Config File (edit this!!!) " \
  && mkdir -p ~/.zcash \
  && echo " listen=0 \ n \
            server=1 \n \
	    port=8233 \n \
	    rpcport=8232 \n \
	    rpcallowip=127.0.0.1 \n \
	    rpcuser=YOUR_RANDOM_RPCUSER \n \
	    rpcpassword=YOUR_RANDOM_RPCPASSWORD \n \
	    proxy=127.0.0.1:9050 \n \
	    maxconnections=8 \n \
	    addnode=mainnet.z.cash \n \
	    addnode=zcashiqykswlzpsu.onion \n \
	    addnode=zcashqhrmju6zfhn.onion \n \
	    addnode=zcashgmvxwrmjsut.onion \n \
	    addnode=zcashz3uma65ix7b.onion \n \
	    addnode=zcashiyf4kxluf3x.onion \n \
	    addnode=zcashwfe4x3jkz2b.onion \n \
	    addnode=zcashvkeki52iqpc.onion \n \
	    addnode=zcasha3cmfrpy7b7.onion \n \
	    addnode=zcashz7ed3nvbdxm.onion \n \
	    addnode=zcash5adwfpxfuvf.onion \n \
	    addnode=zcashixg5ol2ndo4.onion \n \
	    addnode=zcashuzwa365oh3n.onion \n \
	    addnode=zcashskbeoiwtym3.onion \n \
	    addnode=zcashuyvk5e7qfzy.onion \n \
	    addnode=fhsxfrwpyrtoxeal.onion \n \
	    addnode=zcash2iihed2wdux.onion \n \
	    addnode=w3dxku36wbp3lowx.onion" >~/.zcash/zcash.conf

ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib

RUN cp ./zcash-2.0.7/src/zcashd /usr/bin

CMD zcashd


VOLUME /root/.zcash/

EXPOSE 9050 9051

HEALTHCHECK --interval=60s --timeout=15s --start-period=20s \
            CMD curl -sx localhost:9050 'https://check.torproject.org/' | \
            grep -qm1 Congratulations
