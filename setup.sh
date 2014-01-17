#!/bin/bash
echo NODE_ENV=production >> /etc/environment
source /etc/environment

echo Installing dependencies
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
apt-get update
apt-get -y install libssl-dev git-core pkg-config build-essential curl gcc g++ checkinstall vim unzip mongodb-10gen

ver="0.10.24"
echo Installing node version $ver
wget http://nodejs.org/dist/v$ver/node-v$ver.tar.gz
tar -zxf node-v$ver.tar.gz
cd node-v$ver
./configure && make && checkinstall --install=yes --pkgname=nodejs --pkgversion "$ver" --default

echo Installing global npm packages
sudo npm i -g coffee-script phantomjs karma bower pm2 grunt-cli mocha

echo Creating folders
mkdir ~/tmp
mkdir ~/www
mkdir ~/www/laere.co

echo Installing kalxen
cd ~
git clone https://github.com/moongate/kalxen.git
cd kalxen
chmod +x *.sh
chmod +x laere/*.sh
chmod +x laere-ui/*.sh

echo Installing Laere
bash ~/kalxen/laere/download.sh
bash ~/kalxen/laere/install.sh
bash ~/kalxen/laere-ui/download.sh
bash ~/kalxen/laere-ui/install.sh

cd ~/www/laere.co
echo Running Laere
npm start