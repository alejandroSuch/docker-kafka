FROM openjdk:8-jdk-alpine

LABEL author="Alejandro Such <alejandro.such@gmail.com>"

ADD start*.sh /kafka_2.11-0.11.0.0/

RUN apk update && \
    apk add curl bash && \
    curl -O http://apache.mediamirrors.org/kafka/0.11.0.0/kafka_2.11-0.11.0.0.tgz && \
    tar xvzf kafka_2.11-0.11.0.0.tgz && \
    apk del curl && \
    rm -rf /tmp/* /var/cache/apk/* *.tgz && \
    cp /kafka_2.11-0.11.0.0/config/zookeeper.properties /kafka_2.11-0.11.0.0/config/zookeeper.properties.bak && \
    cp /kafka_2.11-0.11.0.0/config/server.properties /kafka_2.11-0.11.0.0/config/server.properties.bak && \
    chmod +x /kafka_2.11-0.11.0.0/start*.sh 

ENV MODE=ZOOKEEPER_AND_KAFKA \ 

    ZOOKEEPER_PORT=2181 \
    ZOOKEEPER_DATA_DIR=/tmp/zookeeper \
    ZOOKEEPER_INIT_LIMIT=5 \
    ZOOKEEPER_SYNC_LIMIT=2 \
    ZOOKEEPER_TICK_TIME=2000 \

    KAFKA_BROKER_ID=0 \
    KAFKA_PORT=9092 \
    KAFKA_LOG_DIRS=/tmp/kafka-logs \
    KAFKA_NUM_PARTITIONS=1 \
    KAFKA_AUTO_CREATE_TOPICS_ENABLE=true \
    KAFKA_DEFAULT_REPLICATION_FACTOR=1 \
    KAFKA_LOG_RETENTION_HOURS=168 \
    KAFKA_ZOOKEEPER_CONNECT=localhost:2181

EXPOSE $KAFKA_PORT
EXPOSE $ZOOKEEPER_PORT

WORKDIR /kafka_2.11-0.11.0.0/
CMD ["/kafka_2.11-0.11.0.0/start.sh"]
