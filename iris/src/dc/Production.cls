Class dc.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="dc.Production" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="BP" Category="" ClassName="Ens.BusinessProcessBPL" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="dc.KafkaProducer" Category="" ClassName="dc.KafkaProducer" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Servers">kafka:29092</Setting>
  </Item>
  <Item Name="dc.KafkaConsumer" Category="" ClassName="dc.KafkaConsumer" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="Topic">test</Setting>
    <Setting Target="Host" Name="Servers">kafka:29092</Setting>
    <Setting Target="Host" Name="TargetConfigNames">BP</Setting>
  </Item>
</Production>
}

}
