# frozen_string_literal: true

require 'helper'

describe Scale::Scheme do
  describe '.transform' do
    it 'amplifies' do
      result = Scale.transform(0.10).using(0..1, 0..127)
      expect(result).to eq(12)
    end
  end

  describe '.from' do
    it 'deamplifies' do
      result = Scale.from(0..150).to(0..15).transform(22)
      expect(result).to eq(2)
    end
  end

  describe '.to' do
    it 'scales neg/pos into pos/pos' do
      result = Scale.to(0..3.0).from(-24..24).transform(10)
      expect(result).to eq(2.125)
    end
  end

  describe '.using' do
    it 'scales neg/pos into another neg/pos' do
      result = Scale.using(-24..24, -3..3.0).transform(10)
      expect(result).to eq(1.25)
    end
  end
end
