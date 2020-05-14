# frozen_string_literal: true

RSpec.describe Nmax::CLI do
  describe '#run' do
    let(:n_arg) { 2 }
    let(:io) { StringIO.new "Smth new12\nBetter Than Others225\n123 12312" }
    let(:input_parser) { instance_double(Nmax::CLI::InputParser, validate: nil, n_arg: n_arg) }
    let(:cli_run) { described_class.new(input_parser: input_parser).run }

    before do
      stub_const('STDIN', io)
    end

    include_context 'with suppressed stderr and stdout'

    it 'returns all numbers from STDIN' do
      expect { cli_run }.to output("12312\n225\n").to_stdout
    end

    it 'calls input parser validator' do
      cli_run

      expect(input_parser).to have_received(:validate)
    end
  end
end
