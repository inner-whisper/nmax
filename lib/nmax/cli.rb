# frozen_string_literal: true

module Nmax
  # This class is responsible for command line interface logic
  class CLI
    attr_reader :input_parser

    def initialize(input_parser = Nmax::CLI::InputParser.new)
      @input_parser = input_parser
    end

    def run
      input_parser.validate

      text = STDIN.read

      numbers_from_text = text.scan(/\d+/).map(&:to_i)
      max_numbers_from_text = numbers_from_text.max(n_arg)
      puts max_numbers_from_text.join("\n")
    end

    private

    def n_arg
      @n_arg ||= input_parser.n_arg
    end
  end
end
