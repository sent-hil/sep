require 'pry'

def reduc(operator)
  Proc.new {|*args| args.reduce(&operator)}
end

GlobalEnviron = {
  :+  => reduc(:+),
  :-  => reduc(:-),
  :*  => reduc(:*),
  :/  => reduc(:/),
  :%  => reduc(:%),
  :>  => reduc(:>),
  :<  => reduc(:<),
  :== => reduc(:==)
}

Environ = {}

class Intepreter
  def eval(tokens, env)
    if self_evaluating?(tokens[0])
      return tokens[0]
    elsif is_definition?(tokens)
      tokens.shift
      tokens.flatten!
      env[tokens[0]] = tokens[1]
      return env
    elsif variable?(tokens)
      lookup_variable(tokens, env)
    elsif tokens[0] == :lambda
      env[tokens.shift].call(tokens)
      return env
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

  def is_lambda(tokens)
    tokens[0] == :lambda
  end

  def variable?(tokens)
    tokens[1].nil?
  end

  def lookup_variable(tokens, env)
    env[tokens[0]]
  end
end

describe Intepreter do
  subject { described_class.new }
  before  { Environ.clear }

  context '#self_evaluating?' do
    it 'returns true for Integer' do
      subject.self_evaluating?(1).should == true
    end

    it 'returns true for String' do
      subject.self_evaluating?('Hello World').should == true
    end
  end

  it 'evals numbers' do
    subject.eval([1], nil).should == 1
  end

  it 'evals strings' do
    subject.eval(['Hello World'], nil).should == 'Hello World'
  end

  it 'evals define variables' do
    subject.eval([:define, [:x], [1]], Environ)[:x].should == 1
  end

  it 'evals variables' do
    Environ[:x] = 1
    subject.eval([:x], Environ).should == 1
  end

  it 'evals'
end
