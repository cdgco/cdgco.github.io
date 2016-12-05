#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ -d "GooGifs" ]
then printf "Pre-existing GooGifs installation detected.\nPlease remove this before continuing (sudo rm -r GooGifs).\n"
exit
fi

echo "                                                       
                                                       
 ██████╗  ██████╗  ██████╗  ██████╗ ██╗███████╗███████╗
██╔════╝ ██╔═══██╗██╔═══██╗██╔════╝ ██║██╔════╝██╔════╝
██║  ███╗██║   ██║██║   ██║██║  ███╗██║█████╗  ███████╗
██║   ██║██║   ██║██║   ██║██║   ██║██║██╔══╝  ╚════██║
╚██████╔╝╚██████╔╝╚██████╔╝╚██████╔╝██║██║     ███████║
 ╚═════╝  ╚═════╝  ╚═════╝  ╚═════╝ ╚═╝╚═╝     ╚══════╝
                                                       "

sleep .5
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' git|grep "install ok installed")
echo Checking for GIT: $PKG_OK
if [ "" == "$PKG_OK" ]; then
  echo "Git not found. Setting up Git."
  sudo apt-get --force-yes --yes install git
else
  printf "Git is already installed.\nMoving on ...\n"
fi
sleep .8
echo "Connecting to GooGifs Repository ..."
sleep .2
git clone https://github.com/cdgco/GooGifs.git
cd GooGifs
rm composer.json
rm appveyor.yml
rm README.md
printf '\n'
echo -n "Would you like to configure GooGifs now (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
rm install -r
printf '<?php\n$pubkey='NULL1';\n$apikey='NULL2';\n$email='NULL3';\n?>' > config.php
echo -n "Please specify publisher key (or leave blank): "
read PUBKEYA
if test "$PUBKEYA" = ""; then
sed -i -e"s/NULL1/'NOT SET'/" config.php
else
sed -i -e"s/NULL1/'$PUBKEYA'/" config.php

fi

echo -n "Do you have a Personal Giphy API Key (y/n)? "
read apia

if echo "$apia" | grep -iq "^n" ;then
read -p "Please specify Giphy API Key: " APIKEYA

if [[ -z "$APIKEYA" ]];then
        printf "Sorry, API Key cannot be blank.\n"
        exit 1;
fi

sed -i -e"s/NULL2/'$APIKEYA'/" config.php
else
sed -i -e"s/NULL2/'dc6zaTOxFJmzC'/" config.php
fi

read -p "Please specify email address: " EMAILA

if [[ -z "$EMAILA" ]] ;then
        printf "Sorry, email address cannot be blank.\n"
        exit 1;
fi

sed -i -e"s/NULL3/'$EMAILA'/" config.php

printf '\n'
echo "GooGifs has now been succesfully configured!"


else
    printf "\n`echo 'Please visit http://'``wget http://ipinfo.io/ip -qO -``echo '/INSTALL-LOCATION/GooGifs to finish configuration.'`\n"
fi
sleep 2
printf "\n"

printf "Thank you for installing GooGifs by CDG Labs!\n\nFor support, visit http://github.complexwebs.com/GooGifs\n\n"
