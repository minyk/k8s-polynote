#!/bin/bash
# This script is intended for use from the docker builds.

set -e -x

SCALA_VERSION="2.12"
SPARK_VERSION="3.3.2"
SPARK_VERSION_DIR="spark-${SPARK_VERSION}"

SPARK_NAME="spark-${SPARK_VERSION}-bin-hadoop3"

pushd /opt
  wget -q "https://archive.apache.org/dist/spark/${SPARK_VERSION_DIR}/${SPARK_NAME}.tgz" && \
  tar zxpf "${SPARK_NAME}.tgz" && \
  mv "${SPARK_NAME}" spark && \
  rm "${SPARK_NAME}.tgz"
popd

echo "export SPARK_DIST_CLASSPATH=\"${SPARK_DIST_CLASSPATH}\"" > /opt/spark/conf/spark-env.sh