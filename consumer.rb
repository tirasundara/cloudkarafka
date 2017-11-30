require 'bundler/setup'
require 'rdkafka'

config = {
          :"bootstrap.servers" => "velomobile-01.srvs.cloudkafka.com:9094, velomobile-02.srvs.cloudkafka.com:9094, velomobile-03.srvs.cloudkafka.com:9094",
          :"group.id"          => "zvtlbi42",
          :"sasl.username"     => 'zvtlbi42',
          :"sasl.password"     => 'jM2jauRqykPKO0bRwbdimRvyXZo4kS4L',
          :"security.protocol" => "SASL_SSL",
          :"sasl.mechanisms"   => "SCRAM-SHA-256"
}
topic = "zvtlbi42-default"

rdkafka = Rdkafka::Config.new(config)
consumer = rdkafka.consumer
consumer.subscribe(topic)

begin
  consumer.each do |message|
    puts "Message received: #{message}"
  end
rescue Rdkafka::RdkafkaError => e
  retry if e.is_partition_eof?
  raise
end
