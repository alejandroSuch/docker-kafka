#!/bin/bash

echo "MODE IS $MODE"

term_handler(){
    echo "Stopping server(s)..."

    PIDS=$(ps ax | grep java | grep -v grep | awk '{print $1}')

    if [ -z "$PIDS" ]; then
        echo "No zookeeper/kafka servers to stop"
    else
        kill -s TERM $PIDS
    fi

    exit 0
}

trap 'term_handler' SIGTERM SIGINT SIGHUP SIGKILL SIGSTOP EXIT

case $MODE in 
    "ZOOKEEPER_AND_KAFKA")
        echo "Launching Zookeeper and Kafka"
        sh start-zookeeper.sh
        sh start-kafka.sh
        sleep 5
        tail -f logs/server.log logs/zookeeper.out &
    ;;
    "KAFKA")
        echo "Launching kafka standalone"
        sh start-kafka.sh
        sleep 5
        tail -f logs/server.log &
    ;;
    "ZOOKEEPER")
        echo "Launching zookeeper standalone"
        sh start-zookeeper.sh
        sleep 5
        tail -f logs/zookeeper.out &
    ;;
esac

while true; do : ;done
