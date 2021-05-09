# Embedded Python demo
Demo showcasing InterSystems IRIS integration with Kafka via Embedded Python

![](https://raw.githubusercontent.com/eduard93/kafka-empy-demo/master/architecture.PNG)

# Running the demo

1. Install:
    - [docker](https://docs.docker.com/get-docker/)
    - [docker-compose](https://docs.docker.com/compose/install/)
    - [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
2. Execute:

```
git clone https://github.com/eduard93/kafka-empy-demo.git
cd kafka-empy-demo
```

3. Copy a valid `iris.key` in `kafka-empy-demo` folder.
4. Execute

```
docker-compose pull
docker-compose up -d
```

# Demo Production

1. Open Production and test `KafkaProducer` operation by sending a `dc.KafkaRequest` message (topic: `test`, with any text). It would send a message to Kafka via Embedded Python.
2. Open [Kafka Manager](http://localhost:8082) and Navigate to `Resources` > `Topics` > `test` > `Browse Data` > `Fetch` to see that your message is enqueued.
3. Open [Message Viewer](http://localhost:52773/csp/user/EnsPortal.MessageViewer.zen?SOURCEORTARGET=KafkaConsumer) on `KafkaConsumer` service
4. Start `KafkaConsumer` service. It would start receiving messages from `test` topic via Embedded Python. If you want to receive messages from another topic, modify `Topics` setting for the Service.
5. Refresh Message Viewer to see new messages.


## UI

- InterSystems IRIS: `http://localhost:52773/csp/user/EnsPortal.ProductionConfig.zen`
- Eco Kafka Manager: `http://localhost:8082`

## Other ports

- SuperServer: `51773`
- Zookeeper: `2181`
- Kafka: `9092`

