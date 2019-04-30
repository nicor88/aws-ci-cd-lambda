#!/usr/bin/env bash

set -e

ROOT_DIR=${PWD}
BASE_LAMBDAS_DIR=lambdas
BASE_LAMBDA_SRC=src


rm -rf build
mkdir build

cd ${BASE_LAMBDAS_DIR}

for LAMBDA_NAME in *; do
    echo "Building ${LAMBDA_NAME}";

    LAMBDA_SRC_PATH=${LAMBDA_NAME}/${BASE_LAMBDA_SRC}

    rm -rf ${LAMBDA_NAME}/.build
    mkdir -p ${LAMBDA_NAME}/.build
    cp ${LAMBDA_SRC_PATH}/*.py ${LAMBDA_NAME}/.build
    python -m pip --isolated install -t ${LAMBDA_NAME}/.build -r ${LAMBDA_NAME}/requirements.txt
    cd ${LAMBDA_NAME}/.build
    zip -r ${LAMBDA_NAME}.zip .
    mv ${LAMBDA_NAME}.zip ${ROOT_DIR}/build/
    cd ..
    rm -rf .build
    cd ${ROOT_DIR}/${BASE_LAMBDAS_DIR}

done
