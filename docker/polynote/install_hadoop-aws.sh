#!/bin/bash
# This script is intended for use from the docker builds.

set -e -x

HADOOP_VERSION="3.2.0"
AWS_SDK_VERSION="1.11.375"

pushd /opt
wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_VERSION}/hadoop-aws-${HADOOP_VERSION}.jar && mv hadoop-aws-${HADOOP_VERSION}.jar /opt/spark/jars
wget http://aws/aws-java-sdk-bundle-${AWS_SDK_VERSION}.jar && mv aws-java-sdk-bundle-${AWS_SDK_VERSION}.jar /opt/spark/jars
popd
