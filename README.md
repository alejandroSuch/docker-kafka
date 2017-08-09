# Apache Kafka and Zookeeper

This Docker container allows you to launch instances of Apache Kafka and Apache Zookeeper.

The can be launched in the same container on in a clusterized way.

## Environment variables

### `MODE`

It accepts three possible values:
 - `ZOOKEEPER_AND_KAFKA`. This mode will launch an instance of zookeeper and another one of kafka in the container
 - `ZOOKEEPER`. This mode will launch only an instance of zookeeper in the container
 - `KAFKA`. This mode will launch only an instance of kafka in the container

### Zookeeper

* `ZOOKEEPER_PORT`

Maps to `clientPort` property. Default value is `2181`.

* `ZOOKEEPER_DATA_DIR`

Maps to `dataDir` property. Default value is `/tmp/zookeeper`

* `ZOOKEEPER_INIT_LIMIT`

Maps to `initLimit` property. Default value is `5`

* `ZOOKEEPER_SYNC_LIMIT`

Maps to `syncLimit` property. Default value is `2`

* `ZOOKEEPER_TICK_TIME`

Maps to `tickTime` property. Default value is `2000`

### Kafka

* `KAFKA_BROKER_ID`

Maps to `broker.id` property. Default value is `0`. If you create a cluster of kafka brokers this number must not be repeated.

* `KAFKA_PORT`

This will add the entry `listeners=PLAINTEXT://$HOSTNAME:$KAFKA_PORT` to the kafka properties. Its default value is `9092`.

* `KAFKA_LOG_DIRS`

Maps to `log.dirs` property. Default value is `/tmp/kafka-logs`

* `KAFKA_NUM_PARTITIONS`

Maps to `num.partitions` property. Default value is `1`.

* `KAFKA_AUTO_CREATE_TOPICS_ENABLE`

Maps to `auto.create.topics.enable` property. Default value is `true`.

* `KAFKA_DEFAULT_REPLICATION_FACTOR`

Maps to `default.replication.factor` property. Default value is `1`.

* `KAFKA_LOG_RETENTION_HOURS`

Maps to `log.retention.hours` property. Default value is `168`.

* `KAFKA_ZOOKEEPER_CONNECT`

Maps to `zookeeper.connect` property. Default value is `localhost:2181`. It accepts a comma-separated list of zookeeper instances in a `host:port` form.

## Running

### Standalone

The default `mode` for the container is `ZOOKEEPER_AND_KAFKA`. So, for running an instance with all servers the command is:

`docker run -p9092:9092 -p2181:2181 -it --rm --hostname kafka alexsuch/kafka:0.11.0.0`

If running locally, and/or don't want to map the `kafka` entry in your `/etc/hosts` file, you can run:

`docker run -p9092:9092 -p2181:2181 -it --rm --hostname localhost alexsuch/kafka:0.11.0.0`

If using `docker-compose`, [here you have](https://github.com/alejandroSuch/docker-kafka/blob/master/docker-compose-samples/docker-compose-all-in-a-server.yml) an example that achieves the same infrastructure.

### Clustering

There are some `docker-compose` files in the [`docker-compose-samples`](https://github.com/alejandroSuch/docker-kafka/tree/master/docker-compose-samples) folder.

- [docker-compose-one-zk-one-kafka.yml](https://github.com/alejandroSuch/docker-kafka/blob/master/docker-compose-samples/docker-compose-one-zk-one-kafka.yml) creates an istance of kafka and zookeeper in two separated containers.
- [docker-compose-one-zk-three-kafkas.yml](https://github.com/alejandroSuch/docker-kafka/blob/master/docker-compose-samples/docker-compose-one-zk-three-kafkas.yml) creates three istances of kafka and one zookeeper in separated containers. The `KAFKA_DEFAULT_REPLICATION_FACTOR` is set to `1` so only one node will replicate.
- [docker-compose-one-zk-two-kafkas.yml](https://github.com/alejandroSuch/docker-kafka/blob/master/docker-compose-samples/docker-compose-one-zk-two-kafkas.yml) is the same scenario as before but with two kafka instances.
- [docker-compose-two-zk-three-kafkas.yml](https://github.com/alejandroSuch/docker-kafka/blob/master/docker-compose-samples/docker-compose-two-zk-three-kafkas.yml) creates three istances of kafka and two zookeeper nodes in separated containers. The `KAFKA_DEFAULT_REPLICATION_FACTOR` is set to `2`, so all brokers will contain replicas of the topics. Besides, the `KAFKA_ZOOKEEPER_CONNECT` contains the two zookeeper instances addresses.
