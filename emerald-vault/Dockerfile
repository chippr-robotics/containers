FROM rust:latest

WORKDIR /root

RUN apt update && apt-get install -y libusb-1.0-0-dev

RUN cargo install emerald-vault

cmd emerald-vault server $RPC_HOST $RPC_PORT
