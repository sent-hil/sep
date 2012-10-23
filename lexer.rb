require 'pry'

class Lexer
  SPECIAL_FORMS = ['lambda', 'define']
  OPENBRACKET   = '('
  CLOSEBRACKET  = ')'

  def lex(sexp)
    token = sexp.shift

    if token == '('
      result = []

      while sexp[0] != ')'
        result << lex(sexp)
      end

      sexp.shift

      return result
    else
      return atom(token)
    end
  end

  def atom(token)
    if token.respond_to?(:to_int)
      token.to_i
    else
      token.to_sym
    end
  end
end

describe Lexer do
  subject do
    described_class.new
  end

  it 'lexes empty list' do
    subject.lex(['(', ')']).should == []
  end

  it 'lexes single parameter list' do
    subject.lex(['(', 'foo', ')']).should == [:foo]
  end

  it 'lexes multi parameter list' do
    subject.lex(['(', 'lambda', '(', 'x', ')', '(', '+', 'x', 'x', ')', ')']).should == [:lambda, [:x], [:+, :x, :x]]
  end
end
