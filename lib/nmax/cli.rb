# frozen_string_literal: true

module Nmax
  # This class is responsible for command line interface logic
  class CLI
    def run
      n = ARGV[0].to_i
      text = STDIN.read

      numbers_from_text = text.scan(/\d+/).map(&:to_i)
      max_numbers_from_text = numbers_from_text.max(n)
      max_numbers_from_text.join("\n")
    end
  end
end
