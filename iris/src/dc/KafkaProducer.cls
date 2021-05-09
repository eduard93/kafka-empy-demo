/// Send Kafka messages
Class dc.KafkaProducer Extends Ens.BusinessOperation
{

/// Internal reference to Kafka producer
Property Producer As %SYS.Python;

/// Kafka server address (comma separated if several)
Property Servers As %String;

Parameter SETTINGS = "Servers:Basic";

Method OnInit() As %Status
{
    #dim sc As %Status = $$$OK
    set kafka = ##class(%SYS.Python).Import("kafka")
    if kafka = 0 {
        set sc = $$$ERROR($$$GeneralError, "kafka module not found")
    } else {
        set ..Producer = kafka.KafkaProducer({"bootstrap_servers":(..Servers), "value_serializer":(..GetLambda())}...)
    }
    quit sc
}

/// Automatically serializes messages into byte objects 
ClassMethod GetLambda() As %SYS.Python [ Language = python ]
{
    return lambda v: v.encode('utf-8')
}

/// Process incoming request
Method OnMessage(request As dc.KafkaRequest, Output response As Ens.Response) As %Status
{
    #dim sc As %Status = $$$OK
    do ..Producer.send(request.Topic, request.Text)
    
    // Actually sends the message
    do ..Producer.flush()
    set response = ##class(Ens.Response).%New()
    quit sc
}

}
