#!/bin/bash

echo "MODE IS $MODE"

case $MODE in 
    "ZOOKEEPER_AND_KAFKA")
        echo "Launching Zookeeper and Kafka"
        sh start-zookeeper.sh -daemon
        sh start-kafka.sh
    ;;
    "KAFKA")
        echo "Launching kafka standalone"
        sh start-kafka.sh
    ;;
    "ZOOKEEPER")
        echo "Launching zookeeper standalone"
        sh start-zookeeper.sh
    ;;
esac