require 'rspec'
require 'pry'

class Tokenizer
  KEYS       = ['(', ')']
  DELIMITERS = [' ', "\n", "\t"]

  attr_reader :output

  def initialize
    @output = []
  end

  def tokenize(input)
    index   = 0
    current = ""

    while index < input.size do
      char = input[index]
      if KEYS.include?(char)
        output << current unless current.empty?
        output << char
        current = ''
      elsif DELIMITERS.include?(char)
        output << current unless current.empty?
        current = ''
      else
        current << char
      end

      index += 1
    end

    output
  end
end

describe Tokenizer do
  subject { described_class.new }

  it 'tokenizes empty list' do
    subject.tokenize("()").should == ['(', ')']
  end

  it 'tokenizes single parameter list' do
    subject.tokenize("(foo)").should == ['(','foo', ')']
  end

  it 'tokenizes multi parameter list' do
    subject.tokenize("(foo bar)").should == ['(','foo', 'bar', ')']
  end

  it 'tokenizes parens inside parens list' do
    subject.tokenize("(foo (bar))").should == ['(','foo', '(', 'bar', ')', ')']
  end

  it 'ignores new lines' do
    subject.tokenize("(foo \n bar)").should == ['(','foo', 'bar', ')']
  end

  it 'ignores tabs' do
    subject.tokenize("(foo \t bar)").should == ['(','foo', 'bar', ')']
  end
end
