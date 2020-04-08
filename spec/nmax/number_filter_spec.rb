# frozen_string_literal: true

RSpec.describe Nmax::NumberFilter do
  describe '#run' do
    let(:numbers_count) { 2 }
    let(:io) do
      string_io = StringIO.new
      string_io.puts "Smth new12\nBetter Than Others225\n123 12312"
      string_io.rewind
      string_io
    end

    it 'returns all numbers from STDIN' do
      expect(described_class.new.max_numbers_from_io(io: io, numbers_count: numbers_count)).to eq([12_312, 225])
    end
  end
end
