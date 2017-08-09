#!/bin/bash

cp config/server.properties.bak config/server.properties

sed -i -E "s/(broker\.id=).*/\1$KAFKA_BROKER_ID/" config/server.properties
sed -i -E "s/(log\.dirs=).*/\1$(echo $KAFKA_LOG_DIRS | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')/" config/server.properties
sed -i -E "s/(num\.partitions=).*/\1$KAFKA_NUM_PARTITIONS/" config/server.properties
sed -i -E "s/(log\.retention\.hours=).*/\1$KAFKA_LOG_RETENTION_HOURS/" config/server.properties
sed -i -E "s/(zookeeper\.connect=).*/\1$KAFKA_ZOOKEEPER_CONNECT/" config/server.properties

echo "" >> config/server.properties
echo "listeners=PLAINTEXT://$HOSTNAME:$KAFKA_PORT" >> config/server.properties
echo "auto.create.topics.enable=$KAFKA_AUTO_CREATE_TOPICS_ENABLE" >> config/server.properties
echo "default.replication.factor=$KAFKA_DEFAULT_REPLICATION_FACTOR" >> config/server.properties

bin/kafka-server-start.sh -daemon config/server.properties
