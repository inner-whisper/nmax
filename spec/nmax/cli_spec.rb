# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nmax::CLI do
  describe '#run' do
    let(:argv_stub) { [n_arg] }
    let(:n_arg) { '2' }
    let(:not_positive_n_arg_message) { 'Атрибут N должен быть больше нуля.' }

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

    shared_examples 'an aborted script with error message' do
      include_context 'with suppressed stderr and stdout'

      it 'returns warning message and error code' do
        expect { described_class.new.run }.to raise_error(SystemExit, error_message) do |error|
          expect(error.status).to eq(1)
        end
      end
    end

    context 'when ARGV is empty' do
      let(:argv_stub) { [] }

      it_behaves_like 'an aborted script with error message' do
        let(:error_message) { 'В скрипт должен быть передан атрибут N.' }
      end
    end

    context 'when ARGV has more than one argument' do
      let(:argv_stub) { %w(1 2) }

      it_behaves_like 'an aborted script with error message' do
        let(:error_message) { 'Скрипт поддерживает передачу только одного атрибута N.' }
      end
    end

    context 'when N is 0' do
      let(:n_arg) { '0' }

      it_behaves_like 'an aborted script with error message' do
        let(:error_message) { not_positive_n_arg_message }
      end
    end

    context 'when N is negative' do
      let(:n_arg) { '-5' }

      it_behaves_like 'an aborted script with error message' do
        let(:error_message) { not_positive_n_arg_message }
      end
    end
  end
end
