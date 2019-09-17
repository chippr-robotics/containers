FROM node:latest

WORKDIR /usr/src/app

RUN wget https://github.com/BurnsCapital/etc-node-sync/archive/v0.0.2.tar.gz \
  && tar -zxvf v0.0.2.tar.gz \
  && mv etc-node-sync-0.0.2/*  /usr/src/app/ \
  && npm i

CMD ["npm", "start"]

