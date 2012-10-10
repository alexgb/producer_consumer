require 'producer_consumer'

module Enumerable
  def produce(number_of_threads=1, &blk)
    @producer_pool = ProducerConsumer::WorkerPool.new(self, number_of_threads)
    @producer_pool.run(&blk)
    self
  end

  def consume(number_of_threads=1, &blk)
    @consumer_pool = ProducerConsumer::ConsumerPool.new(@producer_pool, number_of_threads)
    @consumer_pool.run(&blk)
    @producer_pool.wait
    @consumer_pool.wait
  end
end