# frozen_string_literal: true

module Nmax
  # This class is responsible for command line interface logic
  class CLI
    def run
      validate_input

      text = STDIN.read

      numbers_from_text = text.scan(/\d+/).map(&:to_i)
      max_numbers_from_text = numbers_from_text.max(n_arg)
      puts max_numbers_from_text.join("\n")
    end

    private

    def n_arg
      @n_arg ||= ARGV[0].to_i
    end

    def validate_input
      help_string = 'Прочитайте --help для справки'

      abort "В скрипт должен быть передан атрибут N. #{help_string}" if ARGV.empty?
      abort "Атрибут N должен быть больше нуля. #{help_string}" if n_arg <= 0
    end
  end
end
