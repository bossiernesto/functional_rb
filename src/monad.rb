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

  abstract_methods :bind
  attr_accessor :_value

  alias_method '>>='.to_sym, :bind

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
    self.bind func
  end

  def +(func)
    self >> lambda{|_| func.call _}
  end

end

class IdentityMonad < Monad
  def bind(func)
    self.class.unit(func.call self.value)
  end
end

class Maybe < IdentityMonad
  def bind(func)
    if self.value
      return func.call self.value
    end
    nil
  end
end

class Maybe_Nothing < Maybe
  def bind(functor)
    Nothing
  end
end

Nothing = Maybe_Nothing

class Just < Maybe
end