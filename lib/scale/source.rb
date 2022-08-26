# frozen_string_literal: true

module Scale
  # These are the classes that describe what range the transformed number
  # starts in.  They're named after the core Ruby class that the input closest
  # resembles.
  module Source
    # Contains logic for dealing with Ruby's core ::Range as input
    class Range
      # @param [::Range] range A range to operate on
      def initialize(range)
        @range = range
      end

      # @param [Numeric] input
      # @return [Float]
      def numerator(input)
        (input - @range.first).to_f
      end

      # @return [Float]
      def denominator
        (@range.last - @range.first).abs.to_f
      end
    end

    # Contains logic for dealing with input that includes Ruby's core ::Enumerable
    class Enumerable
      # @param [::Enumerable] enum An enumerable (Array, Set, etc) to operate on
      def initialize(enum)
        @enum = enum
      end

      # @param [Numeric] input
      # @return [Float]
      def numerator(input)
        @enum.to_a.index(input).to_f
      end

      # @return [Float]
      def denominator
        (@enum.size - 1).to_f
      end
    end

    # Map Ruby classes/modules to scaling source classes/modules
    MAP = {
      ::Enumerable => Source::Enumerable,
      ::Range => Source::Range
    }.freeze

    # Build the appropriate scaling source class for the given Ruby object
    # @param [::Enumerable] source
    # @return [Scale::Source::Enumerable, Scale::Source::Range]
    def self.new(source)
      klass = MAP[source.class]
      if klass.nil?
        klasses = MAP.select { |k, _v| source.is_a?(k) }
        klass = klasses.values.first
      end
      klass&.new(source)
    end
  end
end
