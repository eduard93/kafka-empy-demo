Class dc.KafkaRequest Extends Ens.Request
{

Property Topic As %String(MAXLEN = 255) [ Required ];

Property Text As %VarString;

Storage Default
{
<Data name="KafkaRequestDefaultData">
<Subscript>"KafkaRequest"</Subscript>
<Value name="1">
<Value>Topic</Value>
</Value>
<Value name="2">
<Value>Text</Value>
</Value>
</Data>
<DefaultData>KafkaRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
