# frozen_string_literal: true

module Nmax
  # This class is responsible for command line interface logic
  class CLI
    def run
      validate_argv
      validate_stdin

      text = STDIN.read

      numbers_from_text = text.scan(/\d+/).map(&:to_i)
      max_numbers_from_text = numbers_from_text.max(n_arg)
      puts max_numbers_from_text.join("\n")
    end

    private

    def n_arg
      @n_arg ||= ARGV[0].to_i
    end

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
