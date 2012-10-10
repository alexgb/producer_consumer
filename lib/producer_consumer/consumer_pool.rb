require 'producer_consumer/worker_pool'

module ProducerConsumer

  # A ConsumerPool is a special type of worker pool where the input is
  # another WorkerPool instance.
  class ConsumerPool < WorkerPool

    def initialize(producer, number_of_threads=1)
      @producer = producer
      super([], number_of_threads)
    end

    def do_work
      while @producer.alive? || (not @producer.output_queue.empty?)
        @output_queue << yield(@producer.output_queue.pop)
      end
    end

  end
end