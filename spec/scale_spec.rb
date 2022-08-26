# frozen_string_literal: true

require 'helper'
require 'set'

describe Scale do
  describe '#transform' do
    it 'amplifies' do
      result = Scale.transform(0.10).using(0..1, 0..127)
      expect(result).to eq(12)
    end

    it 'deamplifies' do
      result = Scale.transform(22).using(0..150, 0..15)
      expect(result).to eq(2)
    end

    it 'scales neg/pos into pos/pos' do
      result = Scale.transform(10).using(-24..24, 0..3.0)
      expect(result).to eq(2.125)
    end

    it 'scales neg/pos into another neg/pos' do
      result = Scale.transform(10).using(-24..24, -3..3.0)
      expect(result).to eq(1.25)
    end

    it 'scales neg/neg into neg/pos' do
      result = Scale.transform(-14).using(-24..-12, -3..3.0)
      expect(result).to eq(2)
    end

    it 'scales neg/neg to another neg/neg' do
      result = Scale.transform(-16).using(-24..-12, -5..-3.0)
      expect(result).to eq(-3.666666666666667)
    end

    it 'scales neg/neg to pos/pos' do
      result = Scale.transform(-18).using(-24..-12, 1..3.0)
      expect(result).to eq(2)
    end

    it 'takes an array as the source' do
      result = Scale.transform(8).using([0, 2, 4, 8, 16, 64], 0..10)
      expect(result).to eq(6)
    end

    it 'takes an set as the source' do
      result = Scale.transform(8).using(Set.new([0, 2, 4, 8, 16, 64]), 0..10)
      expect(result).to eq(6)
    end

    it 'outputs a float when specified' do
      result = Scale.transform(12).using(0..120, 0..1.0)
      expect(result).to eq(0.10)
    end

    it 'takes an ascending array as the destination' do
      result = Scale.transform(0.40).using(0..1, [0, 2, 4, 8, 12, 16, 32, 64, 128, 512])
      expect(result).to eq(8)
    end

    it 'takes a descending array as the destination' do
      result = Scale.transform(0.40).using(0..1, [512, 128, 64, 32, 16, 12, 8, 4, 2, 0])
      expect(result).to eq(32)
    end

    it 'takes a set as the destination' do
      result = Scale.transform(0.40).using(0..1, Set.new([0, 2, 4, 8, 12, 16, 32, 64, 128, 512]))
      expect(result).to eq(8)
    end
  end
end
