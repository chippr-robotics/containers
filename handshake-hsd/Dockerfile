FROM node:8

WORKDIR /root

RUN git clone git://github.com/handshake-org/hsd.git  &&\
    cd hsd && \
    npm install --production

cmd ./bin/hsd

volume ./data:/root/.hsd/
