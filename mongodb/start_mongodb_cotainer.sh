#!/bin/bash
# @Author: abhijit
# @Date:   24-May-2018 14-05-75
# @Last modified by:   abhijit
# @Last modified time: 24-May-2018 15-05-85
# pass the name
if ["$1" == ""]
    then
    echo "must be envoked only with the path to the directory which will act as storage for mongodb"
    exit 1
fi
mkdir -p $1
docker run \
--restart unless-stopped \
--name mongodb_database \
-p 27017:27017 \
-d \
-v $1:/data/db \
mongo:3.6.4
