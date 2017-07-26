# Apache Kafka and Zookeeper

### Running

`docker run -p9092:9092 -p2181:2181 -it --rm --hostname kafka alexsuch/kafka:0.11.0.0`

If running locally, and/or don't want to add the `kafka` entry to `/etc/hosts`, you can run:

`docker run -p9092:9092 -p2181:2181 -it --rm --hostname localhost alexsuch/kafka:0.11.0.0`

A `docker-compose.yml` file is also provided.
