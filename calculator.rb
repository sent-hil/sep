require 'rspec'
require 'pry'

class Function
  attr_accessor :arguments, :operator

  def initialize(*arguments)
    @operator  = arguments.shift
    @arguments = arguments
  end

  def nested?
    results = arguments.select do |arg|
      arg.respond_to?(:node?)
    end

    !results.uniq.empty?
  end

  def last_node?
    !nested?
  end

  def next_node
    results = arguments.select do |arg|
      arg.respond_to?(:node?)
    end

    results.first
  end

  def node?
    true
  end

  def eval
    if last_node?
      arguments.first.send(operator, arguments.last)
    else
      result = next_node.eval
      arguments.first.send(operator, result)
    end
  end
end

describe Function do
  context 'single nodes' do
    subject { described_class.new(:+, 1, 2) }

    it 'returns false for nested' do
      subject.nested?.should == false
    end

    it 'returns true for last node' do
      subject.last_node?.should == true
    end

    it 'returns result of eval' do
      subject.eval.should == 3
    end
  end

  context 'double nodes' do
    subject do
      described_class.new(:+, 4, (described_class.new(:*, 1, 2)))
    end

    it 'returns true for nested' do
      subject.nested?.should == true
    end

    it 'returns false for last node' do
      subject.last_node?.should == false
    end

    it 'returns result of eval' do
      subject.eval.should == 6
    end
  end
end
