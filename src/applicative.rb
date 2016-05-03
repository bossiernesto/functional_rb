require_relative '../src/abstract'

module Functional

  module Applicative
    extend Abstract

    abstract_methods :apply

    def *(val)
      self.apply val
    end

    def lift_a2(fn, val)
      #liftA2 :: (Applicative f) => (a -> b -> c) -> f a -> f b -> f c.
      fn % self * val

    end

  end

  ::Proc.class_eval do
    def *(fn)
      fn.apply(&self)
    end
  end

end