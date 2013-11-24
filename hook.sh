#!/bin/bash

# First, get the zip file
cd ~/tmp/ && wget -O master.zip -q https://github.com/moongate/laere/archive/master.zip

echo 'Finished downloading master'

# Second, unzip it, if the zip file exists
if [ -f ~/tmp/master.zip ]; then
    # Unzip the zip file
    unzip ~/tmp/master.zip
    # Copy project to deploy folder
    cp -rf laere-master/. ~/www/laere.co/
    echo 'Moved project to www'

    # Delete zip file
    rm ~/tmp/master.zip
    rm -rf laere-master

    cd ~/www/laere.co
    echo $(date) SHUTTING DOWN SERVER FOR UPDATE!
    forever stop server.coffee
    bower i --allow-root
    npm i
    echo $(date) Compiling static assets...
    grunt dist
    echo $(date) Starting up server!
    NODE_ENV=production forever start -c coffee -l forever-laere.log -o out.log -e err.log -a server.coffee
fi
