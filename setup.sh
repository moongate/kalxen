#!/bin/bash
echo Installing dependencies
apt-get update
apt-get -y install libssl-dev git-core pkg-config build-essential curl gcc g++ checkinstall vim unzip mongodb

ver="0.10.20"
echo Installing node version $ver
wget http://nodejs.org/dist/v$ver/node-v$ver.tar.gz
tar -zxf node-v$ver.tar.gz
cd node-v$ver
./configure && make && checkinstall --install=yes --pkgname=nodejs --pkgversion "$ver" --default

echo Installing global npm packages
sudo npm i -g coffee-script grunt-cli phantomjs karma bower bower-installer forever

echo Creating folders
cd ~
mkdir ~/www
mkdir ~/www/laere.co

echo Installing kalxen
git clone https://github.com/moongate/kalxen.git
chmod +x ./kalxen/hook.sh
cd kalxen
npm i
forever start -l forever.log -o out.log -e err.log kalxen.js

echo Running Laere
cd ~
bash ./kalxen/hook.sh
cd ~/www/laere.co
npm i
NODE_ENV=production grunt