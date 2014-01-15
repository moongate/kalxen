#!/bin/bash

# Unzip and overwrite changes
unzip -o ~/tmp/laere-ui-master.zip -d ~/tmp

# Install and compile static assets
cd ~/tmp/laere-ui-master/
npm i --production

# Clean public folder
rm -rf ~/www/laere.co/public/*

# Copy assets to public folder
cp -rf ~/tmp/laere-ui-master/dist/* ~/www/laere.co/public
echo 'Moved static files to public folder'