# frozen_string_literal: true

require 'helper'
require 'set'

describe Scale::Source do
  describe '.new' do
    it 'recognizes a Range' do
      source = Scale::Source.new(0..1)
      expect(source).to be_a(Scale::Source::Range)
    end

    it 'recognizes an Array' do
      source = Scale::Source.new([0, 10, 20, 50])
      expect(source).to be_a(Scale::Source::Enumerable)
    end

    it 'recognizes an Set' do
      source = Scale::Source.new(Set.new([0, 10, 20, 50]))
      expect(source).to be_a(Scale::Source::Enumerable)
    end
  end
end
