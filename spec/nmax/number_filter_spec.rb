# frozen_string_literal: true

RSpec.describe Nmax::NumberFilter do
  describe '#max_numbers_from_io' do
    let(:numbers_count) { 2 }
    let(:io_content_ending) { '' }
    let(:io_content_beginning) { '' }
    let(:buffer_size) { 15 }
    let(:io_content) { io_content_beginning + "Smth new12\nBetter Than Others225\n123 12312" + io_content_ending }
    let(:io) { StringIO.new io_content }
    let(:output) { [12_312, 225] }

    before do
      stub_const('Nmax::NumberFilter::BUFFER_SIZE', buffer_size)
    end

    shared_examples 'a correct filter' do
      it 'returns numbers_count numbers from io' do
        expect(described_class.new.max_numbers_from_io(io: io, numbers_count: numbers_count)).to eq(output)
      end
    end

    it_behaves_like 'a correct filter'

    context 'when io is ended by text' do
      let(:io_content_ending) { 'fdsd' }

      it_behaves_like 'a correct filter'
    end

    context 'when io is ended by space' do
      let(:io_content_ending) { ' ' }

      it_behaves_like 'a correct filter'
    end

    context 'when the middle of the number is in the end of buffered chunk' do
      let(:io_content_beginning) { '123121356' }
      let(:buffer_size) { 4 }
      let(:output) { [123_121_356, 12_312] }

      it_behaves_like 'a correct filter'
    end

    context 'when the end of the number is in the end of buffered chunk' do
      let(:io_content_beginning) { '123121356' }
      let(:buffer_size) { 9 }
      let(:output) { [123_121_356, 12_312] }

      it_behaves_like 'a correct filter'
    end

    context 'when the beginning of the number is in the beginning of buffered chunk' do
      let(:io_content_beginning) { 'abcd123121356' }
      let(:buffer_size) { 4 }
      let(:output) { [123_121_356, 12_312] }

      it_behaves_like 'a correct filter'
    end
  end
end
