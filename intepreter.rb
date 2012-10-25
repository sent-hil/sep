require 'pry'

#def reduc(operator)
  #Proc.new {|*args| args.reduce(&operator)}
#end

#GlobalEnviron = [{
  #:+   => 1,
  #:-   => 2
  #:+  => reduc(:+),
  #:-  => reduc(:-),
  #:*  => reduc(:*),
  #:/  => reduc(:/),
  #:%  => reduc(:%),
  #:>  => reduc(:>),
  #:<  => reduc(:<),
  #:== => reduc(:==)
#}]

# loop to look up envs to find var
#while env[0] || env[1]
  #if env[0].has_key?(opt)
    #break env[0][opt]
  #else
    #env = env[1]
  #end
#end

class Lisp
  GlobalEnviron = [{
    :+ => proc {|args| args.reduce(:+)}
  }]

  def evalulate(tokens, env=GlobalEnviron)
    if self_evaluating?(tokens[0])
      return tokens[0]
    elsif definition?(tokens)
      env[0][tokens[1][0]] = tokens[1][1]
      return env
    elsif lookup_definition?(tokens)
      loop do
        if env[0].has_key?(tokens[0])
          break env[0][tokens[0]]
        else
          if env[1]
            env = env[1]
          else
            break nil
          end
        end
      end
    elsif lumbda?(tokens)
      function = evalulate(tokens[1])
      results = tokens[2].map do |tok|
        evalulate([tok])
      end

      return function.call(results)
    end
  end

  def self_evaluating?(token)
    [Integer, String].each do |klass|
      return true if token.is_a?(klass)
    end

    false
  end

  def definition?(tokens)
    tokens[0] == :define && tokens[2].nil?
  end

  def lookup_definition?(tokens)
    tokens[0].is_a?(Symbol) && tokens.size == 1
  end

  def lumbda?(tokens)
    tokens[0] == :lumbda
  end
end

#class Intepreter
  #def eval(tokens, env)
    #if self_evaluating?(tokens[0])
      #return tokens[0]
    #elsif is_definition?(tokens)
      #tokens.shift
      #tokens.flatten!
      #env[tokens[0]] = tokens[1]
      #return env
    #elsif variable?(tokens)
      #lookup_variable(tokens, env)
    #elsif tokens[0] == :lambda
      #tokens.shift
      #result = GlobalEnviron[tokens[1]].call(tokens[1])
      #return result
    #end
  #end

  #def self_evaluating?(token)
    #[Integer, String].each do |klass|
      #return true if token.is_a?(klass)
    #end

    #false
  #end

  #def is_definition?(tokens)
    #tokens[0] == :define
  #end

  #def is_lambda(tokens)
    #tokens[0] == :lambda
  #end

  #def variable?(tokens)
    #tokens[1].nil?
  #end

  #def lookup_variable(tokens, env)
    #env[tokens[0]]
  #end
#end
