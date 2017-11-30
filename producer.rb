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
producer = rdkafka.producer

100.times do |i|
  puts "Producing message #{i}"
  producer.produce(
      topic:   topic,
      payload: "Payload #{i}",
      key:     "Key #{i}"
  ).wait
end
