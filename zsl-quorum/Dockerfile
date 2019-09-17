FROM ubuntu:16.04

WORKDIR /root

ENV CVER "0.3.2"
ENV CREL "constellation-$CVER-ubuntu1604"
ENV GOREL go1.9.3.linux-amd64.tar.gz
ENV PATH $PATH:/usr/local/go/bin


RUN apt-get update \
  && apt-get install -y software-properties-common python-software-properties \
     software-properties-common unzip wget git make gcc libsodium-dev build-essential \
     libdb-dev zlib1g-dev libtinfo-dev sysvbanner wrk psmisc

RUN add-apt-repository -y ppa:ethereum/ethereum \
  && apt-get update  \
  && apt-get install -y solc

RUN wget -q https://github.com/jpmorganchase/constellation/releases/download/v$CVER/$CREL.tar.xz 

RUN tar xfJ $CREL.tar.xz \
  && cp $CREL/constellation-node /usr/local/bin/ \ 
  && chmod 0755 /usr/local/bin/constellation-node \
  && rm -rf $CREL

RUN wget -q https://dl.google.com/go/$GOREL \
  && tar xfz $GOREL \
  && mv go /usr/local/go \
  && rm -f $GOREL \
  && PATH=$PATH:/usr/local/go/bin \
  && echo 'PATH=$PATH:/usr/local/go/bin' >> /root/.bashrc 

RUN git clone https://github.com/jpmorganchase/quorum.git
#WORKDIR /root/quorum
#RUN git checkout zsl_geth1.5 
RUN cd quorum && git checkout zsl_geth1.5 && make all &&  cp build/bin/geth /usr/local/bin && cp build/bin/bootnode /usr/local/bin


#RUN make \
 # && cp build/bin/geth /usr/local/bin \
  #&& cp build/bin/bootnode /usr/local/bin

EXPOSE 8545 9001 30303

ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib
