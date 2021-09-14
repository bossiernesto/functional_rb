require_relative '../src/abstract'

module Functional

  module Monad
    extend Abstract

    abstract_methods :bind
    attr_accessor :_value

    alias_method '>>='.to_sym, :bind

    def >>(fn)
      self.bind fn
    end

    def +(fn)
      self >> proc { |_| fn.call _ }
    end

  end

end
