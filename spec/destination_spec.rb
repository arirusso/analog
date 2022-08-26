# frozen_string_literal: true

require 'helper'

describe Scale::Destination do
  describe '.new' do
    it 'recognizes a Range' do
      dest = Scale::Destination.new(0..1)
      expect(dest).to be_a(Scale::Destination::Range)
    end

    it 'recognizes an Array' do
      dest = Scale::Destination.new([0, 10, 20, 50])
      expect(dest).to be_a(Scale::Destination::Enumerable)
    end

    it 'recognizes an Set' do
      dest = Scale::Destination.new(Set.new([0, 10, 20, 50]))
      expect(dest).to be_a(Scale::Destination::Enumerable)
    end
  end
end
