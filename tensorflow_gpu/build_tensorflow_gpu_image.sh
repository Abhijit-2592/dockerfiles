#!/bin/bash
# @Author: abhijit
# @Date:   24-May-2018 16-05-47
# @Last modified by:   abhijit
# @Last modified time: 2018-09-15T00:15:27+05:30

TAGNAME=tensorflow_gpu:v1
docker build -t $TAGNAME --build-arg username=$USER --build-arg userid=$UID .
