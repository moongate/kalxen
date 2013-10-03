#!/bin/bash
echo 'Installing dependencies...'
apt-get update
apt-get -y install libssl-dev git-core pkg-config build-essential curl gcc g++ checkinstall vim

ver="0.10.20"
echo Installing node version $ver
wget http://nodejs.org/dist/v$ver/node-v$ver.tar.gz
tar -zxf node-v$ver.tar.gz
cd node-v$ver
./configure && make && checkinstall --install=yes --pkgname=nodejs --pkgversion "$ver" --default

sudo npm i -g coffee-script grunt-cli phantomjs karma bower bower-installer
