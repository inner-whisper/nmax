# frozen_string_literal: true

RSpec.describe Nmax::InversedSortedCollection do
  describe '.new' do
    let(:input_array) { [2, 10, 1, 5] }
    let(:length_limit) { 6 }
    let(:collection) { described_class.new(array: input_array, length_limit: length_limit) }
    let(:array) { collection.array }

    it 'sorts array' do
      expect(array).to eq([10, 5, 2, 1])
    end

    context 'when length_limit is smaller than length of array' do
      let(:length_limit) { input_array.size - 2 }

      it 'limits array by length' do
        expect(array).to eq([10, 5])
      end
    end

    context 'when length_limit is String' do
      let(:length_limit) { 'asd' }

      it { expect { collection }.to raise_error ArgumentError }
    end

    context 'when input_array is a String with number' do
      let(:input_array) { '123' }

      it { expect(array).to eq([123]) }
    end

    context 'when input_array is a String with number with leading zeros' do
      let(:input_array) { '00123' }

      it { expect(array).to eq([123]) }
    end

    context 'when input_array is a String with all zeros' do
      let(:input_array) { '00000' }

      it { expect(array).to eq([0]) }
    end

    context 'when input_array is a String with word symbols' do
      let(:input_array) { 'abs' }

      it { expect { collection }.to raise_error ArgumentError }
    end
  end

  describe '#<<' do
    let(:length_limit) { 6 }
    let(:input_array) { [10, 5, 2, 1] }
    let(:collection) { described_class.new(array: input_array, length_limit: length_limit) }
    let(:array) { collection.array }
    let(:add_value_hook) { collection << added_value }

    before do
      add_value_hook
    end

    context 'when added_value is in the middle of collection' do
      let(:added_value) { 3 }

      it { expect(array).to eq([10, 5, 3, 2, 1]) }
    end

    context 'when added_value is in the beginning of collection' do
      let(:added_value) { -1 }

      it { expect(array).to eq([10, 5, 2, 1, -1]) }
    end

    context 'when added_value is in the end of collection' do
      let(:added_value) { 20 }

      it { expect(array).to eq([20, 10, 5, 2, 1]) }
    end

    context 'when added_value is equal to collection minimum' do
      let(:added_value) { 1 }

      it { expect(array).to eq([10, 5, 2, 1, 1]) }
    end

    context 'when added_value is equal to collection maximum' do
      let(:added_value) { 10 }

      it { expect(array).to eq([10, 10, 5, 2, 1]) }
    end

    context 'when added_value is equal to any value in the middle of collection' do
      let(:added_value) { 5 }

      it { expect(array).to eq([10, 5, 5, 2, 1]) }
    end

    context 'when added_value is String, containing number' do
      let(:added_value) { '5' }

      it { expect(array).to eq([10, 5, 5, 2, 1]) }
    end

    context 'when added_value is String, containing number with leading zeros' do
      let(:added_value) { '00135' }

      it { expect(array).to eq([135, 10, 5, 2, 1]) }
    end

    context 'when added_value is String with all zeros' do
      let(:added_value) { '00000' }

      it { expect(array).to eq([10, 5, 2, 1, 0]) }
    end

    context 'when added_value is String, does not containing number' do
      let(:added_value) { 'abc' }
      let(:add_value_hook) {}

      it { expect { collection << added_value }.to raise_error ArgumentError }
    end

    context 'when length is constrained' do
      let(:added_value) { 5 }
      let(:length_limit) { 4 }

      it { expect(array).to eq([10, 5, 5, 2]) }
    end

    context 'when input_array is empty' do
      let(:input_array) { [] }
      let(:added_value) { 5 }

      it { expect(array).to eq([5]) }
    end
  end
end
