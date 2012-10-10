require 'producer_consumer'
require 'producer_consumer/core_ext/enumerable'

describe ProducerConsumer do

  describe Array do

    subject { ('a'..'z').to_a }

    it "should respond to produce" do
      should respond_to(:produce)
    end

    it "should respond to consume" do
      should respond_to(:consume)
    end

    it "should iterate through all items through producer and consumer" do
      results = []
      subject.produce(3) do |item|
        "--#{item}--"
      end.consume do |item|
        results << item
      end

      results.size.should eql(26)
      results.all? { |i| i =~ /--\w--/ }.should be
    end

  end

end