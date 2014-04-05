module Scale

  module Source

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

    class Enumerable

      def initialize(enum)
        @enum = enum
      end

      def numerator(input)
        @enum.to_a.index(input).to_f
      end

      def denominator
        (@enum.size - 1).to_f
      end

    end

    MAP = {
      ::Enumerable => Source::Enumerable,
      ::Range => Source::Range
    }      

    def self.new(source)
      klass = MAP[source.class]
      if klass.nil?
        klasses = MAP.select { |k,v| source.kind_of?(k) }
        klass = klasses.values.first
      end
      klass.new(source) unless klass.nil?
    end

  end

end
