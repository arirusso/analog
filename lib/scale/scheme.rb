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

    def from(source)
      @source = Source.new(source)
      if @input.nil? || @destination.nil?
        self
      else
        @destination.scale(@input, @source)
      end
    end

    def to(destination)
      @destination = Destination.new(destination)
      if @input.nil? || @source.nil?
        self
      else
        @destination.scale(@input, @source) 
      end
    end

    def using(source, destination)
      @source = Source.new(source)
      @destination = Destination.new(destination)
      @destination.scale(@input, @source)
    end

  end

end
