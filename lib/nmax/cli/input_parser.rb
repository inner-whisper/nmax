# frozen_string_literal: true

module Nmax
  class CLI
    # This class is responsible for parse CLI input
    class InputParser
      # Validates CLI input data
      def validate
        validate_argv
        validate_stdin
      end

      # @return [Integer] parsed value of CLI argument for output number count limit
      def n_arg
        @n_arg ||= ARGV[0].to_i
      end

      private

      def validate_argv
        abort 'В скрипт должен быть передан аргумент N.' if ARGV.empty?
        abort 'Скрипт поддерживает передачу только одного аргумента N.' if ARGV.size > 1
        abort 'Аргумент N должен быть числом, больше нуля.' if n_arg <= 0
      end

      def validate_stdin
        return unless STDIN.tty?

        abort 'Входящий поток не содержит текстовых данных, пример использования скрипта:'\
              ' `cat sample_data_40GB.txt | nmax 10000`'
      end
    end
  end
end
