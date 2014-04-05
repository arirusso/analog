module Scale

  module Destination

    def self.new(destination)
      case destination
      when ::Array then Destination::Array.new(destination)
      when ::Range then Destination::Range.new(destination)
      end
    end

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

    class Array

      def initialize(array)
        @array = array
      end

      def scale(input, source)
        proportion = source.numerator(input) / source.denominator
        index = [((proportion * @array.size).to_i - 1), 0].max
        @array.at(index)
      end

    end

  end

end
