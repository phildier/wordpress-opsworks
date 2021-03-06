#!/bin/bash -ex

chefdk=chefdk_0.4.0-1_amd64.deb

# install chef dev kit. (includes berkshelf, needed below)
if [ ! -f /vagrant/cache/$chefdk ]; then
	wget -qO /vagrant/cache/$chefdk https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/$chefdk
	dpkg -i /vagrant/cache/$chefdk
fi

apt-get -y install git

# install 3rd party cookbooks
cd /vagrant
berks vendor --except site
