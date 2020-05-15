#!/bin/bash
# This script is intended for use from the docker builds.

set -e -x

SCALA_VERSION="2.12"
SPARK_VERSION="3.0.1-SNAPSHOT"
SPARK_VERSION_DIR="spark-${SPARK_VERSION}"

SPARK_NAME="spark-${SPARK_VERSION}-bin-3.2.0"

pushd /opt
wget -q "http://spark-dist/spark/${SPARK_VERSION_DIR}/${SPARK_NAME}.tgz" && tar zxpf "${SPARK_NAME}.tgz" && mv "${SPARK_NAME}" spark
popd
