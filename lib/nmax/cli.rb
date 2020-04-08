# frozen_string_literal: true

module Nmax
  # This class is responsible for command line interface logic
  class CLI
    attr_reader :input_parser, :number_filter

    def initialize(input_parser: Nmax::CLI::InputParser.new, number_filter: Nmax::NumberFilter.new)
      @input_parser = input_parser
      @number_filter = number_filter
    end

    def run
      input_parser.validate

      puts number_filter.max_numbers_from_io(io: STDIN, numbers_count: n_arg).join("\n")
    end

    private

    # TODO: переделать на делегирование
    def n_arg
      @n_arg ||= input_parser.n_arg
    end
  end
end
