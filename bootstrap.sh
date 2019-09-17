sleep $CLI_DELAY
# Check that legacy Docker is not running / installed
sudo apt-get --yes --force-yes remove docker docker-engine

# Grab these for aufs storage drivers
sudo apt-get --yes --force-yes \
 install linux-image-extra-virtual

# Check all pre-requisites present
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Add Docker's GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add correct repository from Docker
# WARNING: Don't use the Ubuntu / Docker repo version, it's broken
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update

# Install Docker
sudo apt-get --yes --force-yes install docker-ce docker-compose

#no sudo for docker
sudo groupadd docker
sudo gpasswd -a $USER docker
}
