module Scale

  # Build a scaling scheme for the given input
  # @param [Numeric] input
  # @return [Scale::Scheme]
  def self.transform(input)
    Scheme.new(:input => input)
  end

  # Describes a particular scaling scenario
  class Scheme

    attr_reader :destination, :input, :source

    # @param [Hash] options
    # @option options [Scale::Destination] :destination The destination for this scaling scenario
    # @option options [Scale::Source] :source The source for this scaling scenario
    def initialize(options = {})
      @input = options[:input]
      @source = Source.new(options[:source]) unless options[:source].nil?
      @destination = Destination.new(options[:destination]) unless options[:destination].nil?
    end

    # Set the source for this scaling scenario.  If on calling this method, the scenario
    # has all of its needed properties, the scaled value will be returned.  Otherwise
    # this method will return the updated Scheme object.
    #
    # @param [Scale::Source] source
    # @return [Fixnum, Scale::Scheme]
    def from(source)
      @source = Source.new(source)
      if @input.nil? || @destination.nil?
        self
      else
        @destination.scale(@input, @source)
      end
    end

    # Set the destination for this scaling scenario.  If on calling this method, the 
    # scenario has all of its needed properties, the scaled value will be returned.  
    # Otherwise this method will return the updated Scheme object.
    #
    # @param [Scale::Destination] destination
    # @return [Fixnum, Scale::Scheme]
    def to(destination)
      @destination = Destination.new(destination)
      if @input.nil? || @source.nil?
        self
      else
        @destination.scale(@input, @source) 
      end
    end

    # Set both the source and destination on this scheme
    # @param [Scale::Source] source
    # @param [Scale::Destination] destination
    def using(source, destination)
      @source = Source.new(source)
      @destination = Destination.new(destination)
      @destination.scale(@input, @source)
    end

  end

end
