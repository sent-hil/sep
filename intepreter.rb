require 'pry'

class Lisp
  GlobalEnviron = [{
    :+ => proc {|arg| arg.reduce(:+)},
    :- => proc {|arg| arg.reduce(:-)}
  }]

  def evalulate(tokens, env=GlobalEnviron)
    if tokens.is_a?(String) || tokens.is_a?(Integer)
      return tokens
    elsif tokens.is_a?(Symbol)
      loop do
        if env[0].has_key?(tokens)
          break env[0][tokens]
        else
          if env[1]
            env = env[1]
          else
            break nil
          end
        end
      end
    elsif tokens[0] == :define
      env[0][tokens[1]] = evalulate(tokens[2], env)
    elsif tokens[0] == :lambda
      lumbdas = proc do |arg|
        new_env = [{tokens[1][0] => arg}, env]
        evalulate(tokens[2], new_env)
      end

      return lumbdas
    else
      results = tokens.map do |tok|
        evalulate(tok, env)
      end

      results[0].call(results[1..-1].flatten)
    end
  end

  def self_evaluating?(tokens)
    [Integer, String].each do |klass|
      return true if tokens[0].is_a?(klass)
    end

    false
  end

  def set_variable?(tokens)
    tokens[0] == :define && tokens[1].is_a?(Symbol)
  end

  def lookup_definition?(tokens)
    tokens[0].is_a?(Symbol) && tokens.size == 1
  end

  def lumbda?(tokens)
    tokens[0] == :lumbda
  end
end
