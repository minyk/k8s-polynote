ARG POLYNOTE_VERSION
ARG SCALA_VERSION="2.12"
FROM polynote/polynote:${POLYNOTE_VERSION}-${SCALA_VERSION}

WORKDIR /opt

USER root

COPY install_spark.sh .
RUN chmod +x install_spark.sh && ./install_spark.sh

ENV SPARK_HOME="/opt/spark"
ENV PATH="$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin"

# switch to non-root user
USER ${NB_USER}
