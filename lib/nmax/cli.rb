# frozen_string_literal: true

module Nmax
  # This class is responsible for command line interface logic
  class CLI
    attr_reader :input_parser, :number_filter

    def initialize(input_parser: Nmax::CLI::InputParser.new, number_filter: Nmax::NumberFilter.new)
      @input_parser = input_parser
      @number_filter = number_filter
    end

    # @return filtered numbers to STDOUT
    def run
      input_parser.validate

      puts number_filter.max_numbers_from_io(io: STDIN, numbers_count: input_parser.n_arg)
                        .join("\n")
    end
  end
end
