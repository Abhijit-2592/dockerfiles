#!/bin/bash
# @Author: abhijit
# @Date:   24-May-2018 17-05-74
# @Last modified by:   abhijit
# @Last modified time: 2018-08-19T23:01:04+05:30

echo " "
echo "the following directories will be created and mounted to the container."
echo "base_path_defined_by_user/source_code as /source_code  where you can keep your source codes"
echo "base_path_defined_by_user/data  as /data    where you can keep the data used for deep_learning"
echo "base_path_defined_by_user/workspace as /workspace    workspace for you to work"
echo "base_path_defined_by_user/others as /others    for other requirements "
echo "  "
if ["$1" == ""]
    then
    echo "Usage Error!!!"
    echo "must be envoked only one argument: path to a base directory where all important datas are stored"
    exit 1
fi

mkdir -p $1/data $1/workspace $1/source_code $1/others
nvidia-docker run \
--name pytorch_v1 \
-v $1:/home/pytorch_user \
-p 8889:8888 -p 6007:6006 \
pytorch_gpu:v1
