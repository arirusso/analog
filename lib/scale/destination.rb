module Scale

  module Destination

    class Range

      def initialize(range)
        @range = range
      end

      def scale(input, source)
        to_range_len = (@range.last - @range.first).abs

        proportion = to_range_len.to_f / source.denominator
        abs_output = proportion.to_f * source.numerator(input)
        output = abs_output + @range.first

        float_requested = [@range.first, @range.last].any? { |n| n.kind_of?(::Float) }
        float_requested ? output : output.to_i
      end

    end

    class Enumerable

      def initialize(enum)
        @enum = enum
      end

      def scale(input, source)
        proportion = source.numerator(input) / source.denominator
        index = [((proportion * @enum.size).to_i - 1), 0].max
        @enum.to_a.at(index)
      end

    end

    MAP = {
      ::Enumerable => Destination::Enumerable,
      ::Range => Destination::Range
    }

    def self.new(destination)
      klass = MAP[destination.class]
      if klass.nil?
        klasses = MAP.select { |k,v| destination.kind_of?(k) }
        klass = klasses.values.first
      end
      klass.new(destination) unless klass.nil?
    end

  end

end
