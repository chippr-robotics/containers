FROM alpine:edge

WORKDIR /root

RUN echo "o Updating system" \
  && apk add --update --no-cache\
        git g++ automake libtool libuv linux-headers \
        pkgconfig clang unbound-dev m4 autoconf make libcap

RUN echo "o cloning handshake light" \
    && git clone git://github.com/handshake-org/hnsd.git \
    && cd hnsd \
    && ./autogen.sh \
    && ./configure --disable-dependency-tracking \
    && make

RUN echo "o setting up" \
   && echo 'nameserver 127.0.0.1' | tee /etc/resolv.conf > /dev/null \
   && setcap 'cap_net_bind_service=+ep' /root/hnsd/hnsd

cmd ./hnsd/hnsd -p 4 -r 127.0.0.1:53

volume ./data:/root/.hnsd/
