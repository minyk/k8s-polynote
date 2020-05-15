ARG POLYNOTE_VERSION
ARG SCALA_VERSION="2.12"
FROM polynote/polynote:${POLYNOTE_VERSION}-${SCALA_VERSION}

WORKDIR /opt

USER root

COPY install_spark.sh .
RUN ./install_spark.sh
COPY install_hadoop-aws.sh .
RUN ./install_hadoop-aws.sh

ENV SPARK_HOME="/opt/spark"
ENV HADOOP_HOME="/opt/hadoop-3.2.0"
ENV PATH="$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin"

# switch to non-root user
USER ${NB_USER}
