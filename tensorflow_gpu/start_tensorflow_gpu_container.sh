#!/bin/bash
# @Author: abhijit
# @Date:   24-May-2018 17-05-74
# @Last modified by:   abhijit
# @Last modified time: 24-May-2018 17-05-63

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

docker run \
--name tf_keras \
--user root -d \
--link mongodb_database \
-v $1/source_code:/source_code \
-v $1/data:/data \
-v $1/workspace:/workspace \
-v $others:/others
-p 8888:8888 -p 6006:6006 \
tensorflow_gpu_v1 /root/run_jupyter.sh
