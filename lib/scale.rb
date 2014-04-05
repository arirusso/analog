module Scale

  def self.transform(input)
    Scheme.new(:input => input)
  end

  class Scheme

    attr_reader :destination, :input, :source

    def initialize(options = {})
      @input = options[:input]
      @source = Source.new(options[:source]) unless options[:source].nil?
      @destination = Destination.new(options[:destination]) unless options[:destination].nil?
    end

    def using(source, destination)
      @source = Source.new(source)
      @destination = Destination.new(destination)
      @destination.scale(@input, @source)
    end

  end

  module Source

    def self.new(source)
      case source
      when ::Array then Source::Array.new(source)
      when ::Range then Source::Range.new(source)
      end
    end

    class Range

      def initialize(range)
        @range = range
      end

      def numerator(input)
        (input - @range.first).to_f
      end

      def denominator
        (@range.last - @range.first).abs.to_f
      end

    end

    class Array

      def initialize(set)
        @set = set
      end

      def numerator(input)
        @set.index(input).to_f
      end

      def denominator
        (@set.size - 1).to_f
      end

    end

  end

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
