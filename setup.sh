#!/bin/bash
echo Installing dependencies
apt-get update
apt-get -y install libssl-dev git-core pkg-config build-essential curl gcc g++ checkinstall vim unzip mongodb

ver="0.10.21"
echo Installing node version $ver
wget http://nodejs.org/dist/v$ver/node-v$ver.tar.gz
tar -zxf node-v$ver.tar.gz
cd node-v$ver
./configure && make && checkinstall --install=yes --pkgname=nodejs --pkgversion "$ver" --default

echo Installing global npm packages
sudo npm i -g coffee-script phantomjs karma bower forever grunt-cli

echo Creating folders
cd ~
mkdir ~/tmp
mkdir ~/www
mkdir ~/www/laere.co

echo Installing kalxen
git clone https://github.com/moongate/kalxen.git
chmod +x ./kalxen/hook.sh
cd kalxen
npm i
forever start -l forever-kalxen.log -o out.log -e err.log -a kalxen.js

echo Running Laere
bash ~/kalxen/hook.sh
