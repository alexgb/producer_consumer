# ProducerConsumer

Threaded [producer/consumer](http://en.wikipedia.org/wiki/Producer-consumer_problem) model. Useful when you have an expensive data producer, such as fetching data over many http connections, and an expensive consumer, such as ingesting into a database.

## Installation

Add this line to your application's Gemfile:

    gem 'axle-producer_consumer', :require => 'producer_consumer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install axle-producer_consumer

## Usage

A simple example with simulated expense using an array as the iterator.

    require 'producer_consumer/core_ext/enumerable'

    results = []
    array = ('a'..'z').to_a

    array.produce(3) do |item|
      sleep 1
      "--#{item}--"
    end.consume(2) do |item|
      sleep 0.2
      results << item
    end

    results.inspect #=> ["--a--", "--b--", "--c--", "--d--" ...

In the above we have used three threads to produce each item, sleeping for one second between each iteration of the array. The data is consumed in an additional two threads sleeping for 0.2 seconds between each new item produced by the producers.

Or use the `WorkerPool` and `ConsumerPool` classes directly.

    require 'open-uri'
    require 'net/smtp'
    require 'producer_consumer'
    include ProducerConsumer

    urls = ['http://www.google.com', 'http://www.yahoo.com', 'http://www.bing.com']

    producer = WorkerPool.new(urls, 3)
    producer.run do |url|
      [url.gsub('http://', ''), open(url).read]
    end

    consumer = ConsumerPool.new(producer, 1)
    consumer.run do |(page, page_content)|
      File.open("#{page}.html", "w") { |f| f << page_content }
    end

    producer.wait
    consumer.wait

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
