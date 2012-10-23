require 'rspec'
require 'pry'
#require_relative 'tokenizer'

class Node
  attr_accessor :parent, :child, :body

  def initialize(parent, child)
    @parent = parent
    @child  = child
    @body   = []
  end
end

class Lexer
  SPECIAL_FORMS = ['lambda', 'define']
  OPENBRACKET   = '('
  CLOSEBRACKET  = ')'

  def lex(sexp)
    original = parent = []
    current  = nil

    sexp.each do |s|
      if s == OPENBRACKET
        current = Array.new
        parent << current
        parent = current
        next
      elsif s == CLOSEBRACKET
        current = nil
        next
      elsif SPECIAL_FORMS.include?(s)
        current = Array.new
        parent << current
        parent = current
        current << s
        next
      end

      current << s
    end

    original.flatten
  end
end

class Func
  def initialize(name, *args)
    @name = name
    @args = *args
  end
end

describe Lexer do
  subject do
    described_class.new
  end

  it 'lexes numbers inside parens' do
    subject.lex(["(", "1", ")"]).should == ["1"]
  end

  it 'lexes special forms:lambda' do
    subject.lex(["(", "lambda", "(", "x", ")", "(", "+", "x", "x", ")", ")"]).should == [:lambda, [:x], [:+, :x, :s]]
  end
end
