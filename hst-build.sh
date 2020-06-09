#!/bin/bash
printf "Hestia Web Interface Release Builder\n\n"
printf "Enter release commit hash (7 digit): "
read COMMIT
printf "Enter release version: "
read VERSION

git checkout -b $VERSION 

sed -i "s#releases/download/.*/backend.tar.gz#releases/download/$VERSION/backend.tar.gz#g" hst-backend
sed -i "s#releases/download/.*/backend.tar.gz#releases/download/$VERSION/backend.tar.gz#g" hst-full
sed -i "s#releases/download/.*/backend.tar.gz#releases/download/$VERSION/backend.tar.gz#g" hst-upfull


sed -i "s#git checkout --quiet.*> /dev/null#git checkout --quiet $COMMIT > /dev/null#g" hst-full
sed -i "s#git checkout -f.*> /dev/null#git checkout -f $COMMIT > /dev/null#g" hst-upfull

git commit -a -m "$VERSION"
git push origin $VERSION
git checkout master

printf "Build complete. New branch on Github named $VERSION."
exit 1

fi
