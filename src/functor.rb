require_relative '../src/typechecker/system'
require_relative 'abstract'

module Functional
  # Functors should respect and abide these two laws
  # Haskell:
  #     fmap id  ==  id
  #     fmap (f . g)  ==  fmap f . fmap g
  # Ruby:
  #     x.map id == id(x)
  #     x.map(compose f, g ) == x.map(g).map(f)

  module Functor
    extend Abstract
    extend TypeSystem

    attr_accessor :value

    abstract_methods :map

    def %(&fn)
      self.map(&fn)
    end

    def value
      @value = nil
      mapper = lambda { |x| @value = x }
      self.map(&mapper)
      @value
    end

  end

  ::Proc.class_eval do
    def %(fn)
      fn.map(&self)
    end
  end

end


