#!/bin/bash

set -e

source ./jenkins_version.sh

cp ${BUILDS}/${GPF_PACKAGE} ${WD}
tar xzvf ${BUILDS}/${GPF_PACKAGE} \
    gpf/conda-environment.yml \
    --strip-components=1

docker pull seqpipe/seqpipe-node-base:latest

docker build . -t "${GPF_DEV_DOCKER_IMAGE}" \
    --build-arg GPF_PACKAGE=${GPF_PACKAGE}


rm -f ${WD}/${GPF_PACKAGE}
