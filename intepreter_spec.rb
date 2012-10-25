require_relative 'intepreter'

describe Lisp do
  subject { described_class.new }

  context 'type of token' do
    it 'finds Integer' do
      subject.self_evaluating?(1).should == true
    end

    it 'finds String' do
      subject.self_evaluating?('Hello World').should == true
    end

    it 'finds definition' do
      subject.definition?([:define, [:x, 1]]).should == true
    end

    it 'finds lumbdas aka lambdas' do
      subject.lumbda?([:lumbda, [:+], [1, 1]]).should == true
    end
  end

  it 'evals numbers' do
    subject.evalulate([1]).should == 1
  end

  it 'evals strings' do
    subject.evalulate(['Hello World']).should == 'Hello World'
  end

  it 'evals define variables' do
    env = subject.evalulate([:define, [:x, 1]])
    env[0][:x].should == 1
  end

  it 'evals define variables to current environ' do
    env = [{}]
    subject.evalulate([:define, [:x, 1]], env)
    env[0][:x].should == 1
  end

  it 'evaling does not affect other environs' do
    global = [{}]
    env = [{}, global]
    subject.evalulate([:define, [:x, 1]], env)
    global[0].has_key?(:x).should == false
  end

  it 'eval lookup variables in current env' do
    env = [{:x => 1}]
    subject.evalulate([:x], env).should == 1
  end

  it 'eval lookup variables in one env up' do
    global = [{}]
    above_level = [{:x => 1}, global]
    env = [{}, above_level]
    subject.evalulate([:x], env).should == 1
  end

  it 'eval lookup variables in global env' do
    global = [{:x => 1}]
    env = [{}, global]
    subject.evalulate([:x], env).should == 1
  end

  it 'returns nil for unknown variable' do
    env = [{}]
    subject.evalulate([:x], env).should == nil
  end

  it 'evals lumbda' do
    env = [{:+ => proc {|args| args.reduce(:+)}}, {}]
    subject.evalulate([:lumbda, [:+], [1, 1]], env).should == 2
  end

  it 'evals lumbda with vars' do
    env = [
      {
        :- => proc {|args| args.reduce(:-)},
        :x => 1
    }, {}]

    subject.evalulate([:lumbda, [:+], [:x, :x]], env).should == 2
  end
end

#describe Intepreter do
  #subject { described_class.new }
#
#
  #before  { Environ.clear }

  #context '#self_evaluating?' do
    #it 'returns true for Integer' do
      #subject.self_evaluating?(1).should == true
    #end

    #it 'returns true for String' do
      #subject.self_evaluating?('Hello World').should == true
    #end

    #it 'returns false for list' do
      #subject.self_evaluating?([]).should == false
    #end
  #end

  #it 'evals numbers' do
    #subject.eval([1], nil).should == 1
  #end

  #it 'evals strings' do
    #subject.eval(['Hello World'], nil).should == 'Hello World'
  #end

  #it 'evals define variables' do
    #subject.eval([:define, [:x], [1]], Environ)[:x].should == 1
  #end

  #it 'evals variables' do
    #Environ[:x] = 1
    #subject.eval([:x], Environ).should == 1
  #end

  #it 'evals lambdas' do
    #subject.eval([:lambda, [:x], [:+, :x, :x]], Environ).should == ''
  #end
#end
