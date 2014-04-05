module Scale

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

end
