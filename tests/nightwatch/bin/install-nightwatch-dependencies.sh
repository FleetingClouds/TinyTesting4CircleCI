#!/bin/bash
#
# echo $(dirname $0)
# cd $(dirname $0)/..
#
# echo "  -- Ready to install NightWatch runner dependencies in -- $(pwd)."
echo "  -- Ready to install NightWatch runner dependencies."
#
export GLOBAL_NODEJS=$(npm config get prefix)
export GLOBAL_NODEJS_MODULES=${GLOBAL_NODEJS}/lib/node_modules
#
export LOCAL_NODEJS=${HOME}
export LOCAL_NODEJS_MODULES=${LOCAL_NODEJS}/node_modules
mkdir -p ${LOCAL_NODEJS_MODULES}
#
modules=( "touch" "bunyan" "underscore" "mkdirp" "nightwatch" "npm" "chromedriver" "minimist" "fs-extra" "request" )
for idx in "${modules[@]}"
do
  :
  if [ ! -d ${LOCAL_NODEJS_MODULES}/${idx}/ ]; then
    echo "Installing '${idx}' in directory -- ${LOCAL_NODEJS_MODULES}."
    npm install -y --prefix ${LOCAL_NODEJS} ${idx};
  else
    echo "Node module '${idx}' is already available.";
  fi;
done
#
MDL="bunyan"
if [ ! -d ${GLOBAL_NODEJS_MODULES}/${MDL}/ ]; then
  echo "Installing '${MDL}' in directory -- ${GLOBAL_NODEJS_MODULES}."
  npm install -y --global --prefix ${GLOBAL_NODEJS} ${MDL};
else
  echo "Node module '${MDL}' is already available.";
fi;

echo "  -- linking to chronedriver -- ${LOCAL_NODEJS_MODULES}."
ln -s ${LOCAL_NODEJS_MODULES}/chromedriver $(dirname $0)/chromedriver
#
echo "  -- installing Selenium in directory -- ${LOCAL_NODEJS_MODULES} $(dirname $0)."

wget -P ${LOCAL_NODEJS_MODULES} --no-clobber http://selenium-release.storage.googleapis.com/2.47/selenium-server-standalone-2.47.1.jar
ln -s ${LOCAL_NODEJS_MODULES}/selenium-server-standalone-2.47.1.jar $(dirname $0)/selenium-server-standalone.jar
#
DIR=$(dirname $0)
echo ">>>${DIR}<<<"
cd ${DIR}
ls -l
pwd
echo "Dependencies loaded."
