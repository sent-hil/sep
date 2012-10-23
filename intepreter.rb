require 'pry'

class Environ
  attr_reader :table

  def initialize
    @table = {}
  end
end

class GlobalEnviron < Environ
end

class Intepreter
  def eval(tokens, env)
    if self_evaluating?(tokens[0])
      return tokens[0]
    elsif is_definition?(tokens)
      env = Environ.new.table[tokens.shift] = tokens
      return env
    else
      env.table[tokens[0]]
    end
  end

  def self_evaluating?(token)
    [Integer, String].each do |klass|
      return true if token.is_a?(klass)
    end

    false
  end

  def is_definition?(tokens)
    tokens[0] == :define
  end
end

describe Intepreter do
  subject do
    described_class.new
  end

  context '#self_evaluating?' do
    it 'returns true for Integer' do
      subject.self_evaluating?(1).should == true
    end
  end

  it 'evals numbers' do
    subject.eval([1], nil).should == 1
  end

  it 'evals strings' do
    subject.eval(['Hello World'], nil).should == 'Hello World'
  end

  it 'evals define variables' do
    subject.eval([:define, [:x], [1]], nil).should ==
      [[:x], [1]]
  end

  it 'evals variables' do
    env = Environ.new
    env.table[:x] = 1
    subject.eval([:x], env).should == 1
  end
end
