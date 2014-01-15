#!/bin/bash

echo Running Laere Deploy
bash ~/kalxen/laere/download.sh
bash ~/kalxen/laere/install.sh
cd ~/www/laere.co
npm restart