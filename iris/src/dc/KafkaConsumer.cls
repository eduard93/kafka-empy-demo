/// Receive Kafka messages
Class dc.KafkaConsumer Extends Ens.BusinessService
{

Parameter ADAPTER = "Ens.InboundAdapter";

/// Internal reference to Kafka consumer
Property Consumer As %SYS.Python;

Property JSON As %SYS.Python;

Property Builtins As %SYS.Python;

/// Kafka server address (comma separated if several)
Property Servers As %String;

/// Topic to subscribe to
Property Topic As %String;

/// Configuration item(s) to which to send Kafka messages
Property TargetConfigNames As Ens.DataType.ConfigName;

Parameter SETTINGS = "Servers:Basic,TargetConfigNames:Basic,Topic:Basic";

Method OnInit() As %Status
{
    #dim sc As %Status = $$$OK
    set ..JSON = ##class(%SYS.Python).Import("json")
    set ..Builtins = ##class(%SYS.Python).Import("builtins")

    set kafka = ##class(%SYS.Python).Import("kafka")
    if kafka = 0 {
        set sc = $$$ERROR($$$GeneralError, "kafka module not found")
    } else {
        set ..Consumer = kafka.KafkaConsumer(..Topic, {"bootstrap_servers":(..Servers), "value_deserializer":(..GetLambda())}...)
    }
    quit sc
}

/// Automatically deserializes messages into string 
ClassMethod GetLambda() As %SYS.Python [ Language = python ]
{
    return lambda v: v.decode('utf-8')
}

Method OnProcessInput(request As %RegisteredObject, response As %RegisteredObject) As %Status
{
    #dim sc As %Status = $$$OK
    set messages = ..Consumer.poll(10000)
	set json = ..JSON.dumps(..Builtins.list(messages.values()))
    $$$TRACE(json)
    
    // No messages, exit
    quit:json="[]" sc

    // Process messages
    set messagesArray = [].%FromJSON(json)
    set iterator = messagesArray.%Get(0).%GetIterator()
    while iterator.%GetNext(.key, .value) {
		set text = value.%Get(6)
        set message=##class(Ens.StringRequest).%New(text)
        set sc=..SendRequestAsync(..TargetConfigNames, message)
	}

	quit sc
}

}
