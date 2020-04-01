# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nmax::CLI do
  describe '#run' do
    before do
      io = StringIO.new
      io.puts "Smth new12\nBetter Than Others225\n123 12312"
      io.rewind
      stub_const('STDIN', io)
      stub_const('ARGV', ['2'])
    end

    it 'returns all numbers from STDIN' do
      expect(described_class.new.run).to eq("12312\n225")
    end
  end
end
