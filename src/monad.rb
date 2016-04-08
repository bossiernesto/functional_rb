module Abstract

  # Interface for declaratively indicating that one or more methods are to be
  # treated as abstract methods, only to be implemented in child classes.
  #
  # Arguments:
  # - methods (Symbol or Array) list of method names to be treated as
  #   abstract base methods
  #
  def abstract_methods(*methods)
    methods.each do |method_name|

      define_method method_name do |*args|
        raise NotImplementedError, "This is an abstract base method (#{method_name}). Implement in your subclass."
      end

    end
  end
end


class Monad
  extend Abstract

  abstract_methods :<=
  attr_accessor :_value

  def initialize(value)
    self._value = value
  end

  def self.unit(value)
    self.new(value)
  end

  def value()
    if self._value.is_a? Monad
      return self._value.value
    end
    self._value
  end

  def >>(func)
    self <= func
  end

  def +(func)
    self >> lambda{|_| func.call _}
  end

end

class IdentityMonad < Monad
  def <=(func)
    self.class.unit(func.call self.value)
  end
end

class Maybe < IdentityMonad
  def <=(func)
    if self.value
      return func.call self.value
    end
    nil
  end
end

monad = Monad.new(2)
monad <= lambda{|i| + 2}

identity_m = IdentityMonad.new(30)
foo = identity_m >> lambda {|i| i/2} >> lambda{|i| i*6}
print foo.value

maybe_m = Maybe.new 1

print maybe_m <= lambda {|i| i +4}