#!/bin/bash

EXTRA_ARGS=""
COMMAND=$1
case $COMMAND in
  -daemon)
     EXTRA_ARGS="-daemon"
     ;;
esac

cp config/zookeeper.properties.bak config/zookeeper.properties

sed -i -E "s/(clientPort=)\d+/\1$ZOOKEPER_PORT/" config/zookeeper.properties
sed -i -E "s/(dataDir=).*/\1$(echo $ZOOKEEPER_DATA_DIR | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')/" config/zookeeper.properties

echo "" >> config/zookeeper.properties
echo "initLimit=$ZOOKEEPER_INIT_LIMIT" >> config/zookeeper.properties
echo "syncLimit=$ZOOKEEPER_SYNC_LIMIT" >> config/zookeeper.properties
echo "tickTime=$ZOOKEEPER_TICK_TIME" >> config/zookeeper.properties

if [ -n "${ZOOKEPER_MY_ID}" ]; then
    echo $ZOOKEPER_MY_ID >> "$ZOOKEEPER_DATA_DIR/myid"
fi

if [ -n "${ZOOKEPER_INSTANCES}" ]; then
    IFS=','
    COUNTER=0
    for INSTANCE in $ZOOKEPER_INSTANCES; do 
        echo "server.$COUNTER=$INSTANCE"  >> config/zookeeper.properties
        COUNTER=$((COUNTER+1))
    done
fi

exec bin/zookeeper-server-start.sh $EXTRA_ARGS config/zookeeper.properties