#!/bin/bash
set -e

apt-get update -y

sudo apt-get install \
	apt-transport-https \
	ca-certificates \
	curl \
	software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

apt-key fingerprint 0EBFCD88

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update -y

apt-get install -y -o Dpkg::Options::="--force-confold" docker-ce

apt-get autoremove -y

gpasswd -a ubuntu docker

systemctl daemon-reload
systemctl enable format-var-lib-docker.service
systemctl enable var-lib-docker.mount
systemctl enable docker.service
