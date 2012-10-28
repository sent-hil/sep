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
    elsif tokens[0] == :quote
      return tokens[1..-1].flatten
    elsif tokens[0] == :define
      env[0][tokens[1]] = evalulate(tokens[2], env)
    elsif tokens[0] == :lambda
      lambdas = proc do |arg|
        new_env = [{tokens[1][0] => arg}, env]
        evalulate(tokens[2], new_env)
      end

      return lambdas
    else
      results = tokens.map do |tok|
        evalulate(tok, env)
      end

      results[0].call(results[1..-1].flatten)
    end
  end
end
