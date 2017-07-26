FROM openjdk:8-jdk-alpine

RUN apk update && \
    apk add curl bash && \
    curl -O http://apache.mediamirrors.org/kafka/0.11.0.0/kafka_2.11-0.11.0.0.tgz && \
    tar xvzf kafka_2.11-0.11.0.0.tgz && \
    apk del curl && \
    rm -rf /tmp/* /var/cache/apk/* *.tgz

COPY start.sh /kafka_2.11-0.11.0.0/

EXPOSE 9092
EXPOSE 2181

WORKDIR /kafka_2.11-0.11.0.0/
CMD ["/bin/bash", "start.sh"]