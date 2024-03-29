require_relative 'intepreter'

describe Lisp do
  subject { described_class.new }
  before  do
    Lisp::GlobalEnviron[0] = {
      :+ => proc {|args| args.reduce(:+)},
      :- => proc {|arg| arg.reduce(:-)}
    }
  end

  it 'evals numbers' do
    subject.evalulate(1).should == 1
  end

  it 'evals strings' do
    subject.evalulate('Hello World').should == 'Hello World'
  end

  it 'evals define variables' do
    subject.evalulate([:define, :x, 1])
    Lisp::GlobalEnviron[0][:x].should == 1
  end

  it 'eval lookup variables in current env' do
    env = [{:x => 1}]
    subject.evalulate(:x, env).should == 1
  end

  it 'eval lookup variables in one env up' do
    global = [{}]
    above_level = [{:x => 1}, global]
    env = [{}, above_level]
    subject.evalulate(:x, env).should == 1
  end

  it 'eval lookup variables in global env' do
    Lisp::GlobalEnviron[0][:x] = 1
    subject.evalulate(:x).should == 1
  end

  it 'returns nil for unknown variable' do
    subject.evalulate(:x).should == nil
  end

  it 'evals lambda' do
    subject.evalulate([[:lambda, [:x], [:+, :x, :x]], 1]).should == 2
  end

  it 'evals lambda' do
    subject.evalulate([[:lambda, [:x], [:-, :x, :x]], 1]).should == 0
  end

  xit 'evals define' do
    subject.evalulate(
      [
        [:define, [:add], [:lambda, [:x], [:+, :x, :x]]],
        [:add, 1, 1]
      ]
    ).should == 0
  end

  it 'evals lambda with vars' do
    env = [
      {
        :- => proc {|args| args.reduce(:-)},
        :x => 1
    }, {}]

    subject.evalulate([[:lambda, [:x], [:+, :x, :x]], 1]).should == 2
  end

  it 'evals quotes' do
    subject.evalulate([:quote, [1, 2]]).should == [1,2]
  end
end
