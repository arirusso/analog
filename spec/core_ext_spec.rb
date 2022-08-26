# frozen_string_literal: true

require 'helper'

describe 'CoreExt' do
  before do
    require 'scale/core_ext'
  end

  describe Numeric do
    describe '#scaled' do
      it 'amplifies' do
        result = 0.10.scaled.using(0..1, 0..127)
        expect(result).to eq(12)
      end

      it 'deamplifies' do
        result = 22.scaled.using(0..150, 0..15)
        expect(result).to eq(2)
      end

      it 'scales neg/pos into pos/pos' do
        result = 10.scaled.using(-24..24, 0..3.0)
        expect(result).to eq(2.125)
      end

      it 'scales neg/pos into another neg/pos' do
        result = 10.scaled.using(-24..24, -3..3.0)
        expect(result).to eq(1.25)
      end
    end

    describe '#scaled_using' do
      it 'scales neg/neg into neg/pos' do
        result = -14.scaled_using(-24..-12, -3..3.0)
        expect(result).to eq(2)
      end

      it 'scales neg/neg to another neg/neg' do
        result = -16.scaled_using(-24..-12, -5..-3.0)
        expect(result).to eq(-3.666666666666667)
      end

      it 'scales neg/neg to pos/pos' do
        result = -18.scaled_using(-24..-12, 1..3.0)
        expect(result).to eq(2)
      end
    end

    describe '#scaled_to' do
      context 'when source is an array' do
        it 'scales using the array as a range' do
          result = 8.scaled_to(0..10).from([0, 2, 4, 8, 16, 64])
          expect(result).to eq(6)
        end
      end

      context 'when source is a float' do
        it 'outputs a float' do
          result = 12.scaled_to(0..1.0).from(0..120)
          expect(result).to eq(0.10)
        end
      end
    end

    describe '#scaled_from' do
      context 'when ascending array is the destination' do
        it 'scales using the array as a range' do
          result = 0.40.scaled_from(0..1).to([0, 2, 4, 8, 12, 16, 32, 64, 128, 512])
          expect(result).to eq(8)
        end
      end

      context 'when descending array as the destination' do
        it 'scales using the array as a range' do
          result = 0.40.scaled_from(0..1).to([512, 128, 64, 32, 16, 12, 8, 4, 2, 0])
          expect(result).to eq(32)
        end
      end
    end
  end
end
