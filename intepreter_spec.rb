require_relative 'intepreter'

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

    it 'returns false for list' do
      subject.self_evaluating?([]).should == false
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

  it 'evals lambdas' do
    subject.eval([:lambda, [:x], [:+, :x, :x]], Environ).should == ''
  end
end
