# Kafka Sample Application
This application is based on https://github.com/pascalgrimaud/jhipster-kafka-samples.
Main purpose was to instrument it with Elastic APM Java agent to test how Kibana visualized traces going through Kafka pub/sub queue.

## How to use it
- Clone the project
- Modity elastic.env to include proper Elastic APM server URL and sercet token
- Start using 'docker-compose -f docker-compose-kafka.yml up'
