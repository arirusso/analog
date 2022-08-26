# frozen_string_literal: true

module Scale
  # These are the classes that describe what range the transformed number
  # will wind up in. They're named after the core Ruby class that the input closest
  # resembles.
  module Destination
    # Contains logic for dealing with Ruby's core ::Range as input
    class Range
      # @param [::Range] range A range to operate with
      def initialize(range)
        @range = range
      end

      # Scale the given input and source using this destination
      # @param [Numeric] input A numeric value to scale
      # @param [Scale::Source] source The source for the input value
      # @return [Numeric]
      def scale(input, source)
        result = calculation(input, source)
        float_requested? ? result : result.to_i
      end

      private

      def float_requested?
        [@range.first, @range.last].any? { |n| n.is_a?(::Float) }
      end

      def calculation(input, source)
        to_range_len = (@range.last - @range.first).abs

        proportion = to_range_len.to_f / source.denominator
        abs_output = proportion.to_f * source.numerator(input)
        abs_output + @range.first
      end
    end

    # Contains logic for dealing with input that includes Ruby's core ::Enumerable
    class Enumerable
      # @param [::Enumerable] enum An enumerable (eg Array, Set) to operate with
      def initialize(enum)
        @enum = enum
      end

      # Scale the given input and source using this destination
      # @param [Numeric] input A numeric value to scale
      # @param [Scale::Source] source The source for the input value
      # @return [Numeric]
      def scale(input, source)
        proportion = source.numerator(input) / source.denominator
        index = [((proportion * @enum.size).to_i - 1), 0].max
        @enum.to_a.at(index)
      end
    end

    # Map Ruby classes/modules to scaling destination classes/modules
    MAP = {
      ::Enumerable => Destination::Enumerable,
      ::Range => Destination::Range
    }.freeze

    # Build the appropriate scaling destination class for the given Ruby object
    # @param [::Enumerable] destination
    # @return [Scale::Destination::Enumerable, Scale::Destination::Range]
    def self.new(destination)
      klass = MAP[destination.class]
      if klass.nil?
        klasses = MAP.select { |k, _v| destination.is_a?(k) }
        klass = klasses.values.first
      end
      klass&.new(destination)
    end
  end
end
