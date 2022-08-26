# frozen_string_literal: true

require 'scale'

# Extend the Numeric class to add a scaling helper.
# eg: 0.40.scaled_from(0..1).to([512, 128, 64, 32, 16, 12, 8, 4, 2, 0])
#
# This is not included by default with the rest of the library.  use require "scale/core_ext"
#
class Numeric
  # Build a Scheme for this numeric as input.
  # @return [Scale::Scheme]
  def scaled
    Scale.transform(self)
  end

  # Scale using the given source and destination, with this numeric as input.
  # @param [Scale::Source] source
  # @param [Scale::Destination] destination
  # @return [Numeric]
  def scaled_using(source, destination)
    Scale.transform(self).using(source, destination)
  end

  # Build a scheme with this numeric as input and add the given source to it. If
  # on calling this method, the scheme has all of its needed properties, the scaled
  # value will be returned.  Otherwise # this method will return the updated Scheme
  # object.
  #
  # @param [Scale::Source] source
  # @return [Numeric, Scale::Scheme]
  def scaled_from(source)
    Scale.transform(self).from(source)
  end

  # Build a scheme with this numeric as input and add the given destination to it. If
  # on calling this method, the scheme has all of its needed properties, the scaled
  # value will be returned.  Otherwise # this method will return the updated Scheme
  # object.
  #
  # @param [Scale::Destination] destination
  # @return [Numeric, Scale::Scheme]
  def scaled_to(destination)
    Scale.transform(self).to(destination)
  end
end
