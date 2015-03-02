#!/bin/bash -ex

# install chef dev kit. (includes berkshelf, needed below)
if [ ! -f /tmp/chefdk.deb ]; then
	wget -qO /tmp/chefdk.deb https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.4.0-1_amd64.deb
	dpkg -i /tmp/chefdk.deb
fi

apt-get -y install git

# install 3rd party cookbooks
cd /vagrant
berks vendor --except site
