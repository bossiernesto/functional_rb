require_relative 'monad'
require_relative 'applicative'
require_relative 'functor'

module Functional

  module Maybe

    class Just
      include Functional::Monad
      include Functional::Applicative
      include Functional::Functor

      def initialize(value)
        @_value = value
      end

      def map(&fn)
        Just.new( fn.curry.(@_value))
      end

      def bind(fn = nil, &block)
        (fn || block).curry.(@_value)
      end

      def apply(value)
        value.map { |v| @_value.curry.(v) }
      end

      def to_s
        "Just(#{self.value})"
      end

      def ==(other)
        other.maybe_cmp(false) do |value|
          @_value == value
        end
      end

      def maybe_cmp(_, &fn)
        fn.curry.(@_value)
      end
    end


    class Nothing
      def self.maybe_cmp(value, &fn)
        value
      end

      def self.map(&_)
        self
      end

      def self.bind(_, &block)
        self
      end

      def to_s
        'Nothing'
      end

      def self.apply(_)
        self
      end

      def self.===(other)
        self == other
      end

    end

    def Maybe(value=nil, &fn)
      (value or fn) ? Just.new(value || fn.curry) : Nothing
    end
    alias_method :Just, :Maybe
    alias_method :pure, :Maybe

  end


end