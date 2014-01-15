#!/bin/bash

# Unzip and overwrite changes
unzip -o ~/tmp/laere-master.zip -d ~/tmp

# Copy project to deploy folder
cp -rf ~/tmp/laere-master/* ~/www/laere.co/
echo 'Moved project to www'

cd ~/www/laere.co
mkdir public
npm i --production
