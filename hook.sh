#!/bin/bash

# First, get the zip file
cd ~/tmp/ && wget -O master.zip -q https://github.com/moongate/laere/archive/master.zip

echo 'Finished downloading master'

# Second, unzip it, if the zip file exists
if [ -f ~/tmp/master.zip ]; then
    # Unzip the zip file
    unzip -q ~/tmp/master.zip

    # Delete zip file
    rm ~/tmp/master.zip

    echo 'Unzipped and removed zip'

    # Copy project to deploy folder
    cp -rf laere-master/* ~/www/laere.co/

    echo 'Copied new files'

    rm -rf laere-master

    echo 'Moved project to www'
fi