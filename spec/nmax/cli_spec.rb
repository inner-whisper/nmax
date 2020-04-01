# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nmax::CLI do
  describe '#run' do
    let(:argv_stub) { ['2'] }

    before do
      io = StringIO.new
      io.puts "Smth new12\nBetter Than Others225\n123 12312"
      io.rewind
      stub_const('STDIN', io)
      stub_const('ARGV', argv_stub)
    end

    it 'returns all numbers from STDIN' do
      expect { described_class.new.run }.to output("12312\n225\n").to_stdout
    end

    context 'when ARGV is empty' do
      let(:argv_stub) { [] }

      include_context 'with suppressed stderr and stdout'

      it 'returns warning message and error code' do
        puts_output = 'В скрипт должен быть передан атрибут N. Прочитайте --help для справки'

        expect { described_class.new.run }.to raise_error(SystemExit, puts_output) do |error|
          expect(error.status).to eq(1)
        end
      end
    end
  end
end
