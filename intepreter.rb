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
      tokens.shift
      result = GlobalEnviron[tokens[1]].call(tokens[1])
      return result
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
