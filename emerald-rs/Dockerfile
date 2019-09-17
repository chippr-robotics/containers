FROM alpine:edge

WORKDIR /root


RUN echo "o Updating system" \
  && apk add --update --no-cache\
        git g++ libusb-dev openssl-dev linux-headers pkgconfig rust cargo clang

RUN echo "o Installing emeral-rs" \
  && git clone https://github.com/ETCDEVTeam/emerald-rs.git \
  && cd emerald-rs \
  && OPENSSL_DIR=/root \
  && cargo install emerald-cli

RUN  echo "o  moving files" \
  && cp .cargo/bin/emerald /usr/bin


