# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nmax::CLI::InputParser do
  describe '#validate' do
    let(:argv_stub) { [n_arg] }
    let(:n_arg) { '2' }
    let(:not_positive_n_arg_message) { 'Аргумент N должен быть числом, больше нуля.' }
    let(:io) { instance_double(StringIO, tty?: io_stub_tty) }
    let(:io_stub_tty) { false }

    before do
      stub_const('STDIN', io)
      stub_const('ARGV', argv_stub)
    end

    shared_examples 'an aborted script with error message' do
      include_context 'with suppressed stderr and stdout'

      it 'returns warning message and error code' do
        expect { described_class.new.validate }.to raise_error(SystemExit, error_message) do |error|
          expect(error.status).to eq(1)
        end
      end
    end

    context 'when ARGV is empty' do
      let(:argv_stub) { [] }

      it_behaves_like 'an aborted script with error message' do
        let(:error_message) { 'В скрипт должен быть передан аргумент N.' }
      end
    end

    context 'when ARGV has more than one argument' do
      let(:argv_stub) { %w(1 2) }

      it_behaves_like 'an aborted script with error message' do
        let(:error_message) { 'Скрипт поддерживает передачу только одного аргумента N.' }
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

    context 'when N is not a number' do
      let(:n_arg) { 'minus_five' }

      it_behaves_like 'an aborted script with error message' do
        let(:error_message) { not_positive_n_arg_message }
      end
    end

    context 'when STDIN has no any piped text stream' do
      let(:io_stub_tty) { true }

      it_behaves_like 'an aborted script with error message' do
        let(:error_message) do
          'Входящий поток не содержит текстовых данных, пример использования скрипта:'\
          ' `cat sample_data_40GB.txt | nmax 10000`'
        end
      end
    end
  end
end
