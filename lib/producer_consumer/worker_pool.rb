module ProducerConsumer
  class WorkerPool
    attr_reader :output_queue

    def initialize(input, number_of_threads=1)
      @input = input
      @number_of_threads = number_of_threads
      @workers = []
      @worker_input_queue = Queue.new
      @output_queue = Queue.new
    end

    def run(&blk)
      # put input's items into queue for thread safe access
      @input.each { |item| @worker_input_queue << item }

      @number_of_threads.times do 
        @workers << Thread.new do
          do_work(&blk)
        end
      end
    end

    # worker's unit of work, can be overriden
    def do_work
      until @worker_input_queue.empty?
        @output_queue << yield(@worker_input_queue.pop)
      end
    end

    def alive?
      @workers.any? { |t| t.alive? }
    end

    def wait
      @workers.each { |t| t.join }
    end

  end
end