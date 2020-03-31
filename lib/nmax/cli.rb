# frozen_string_literal: true

module Nmax
  # This class is responsible for command line interface logic
  class CLI
    def run
      n = 2
      text = STDIN.read
      text.scan(/\d+/)[0..(n - 1)].join("\n")
    end
  end
end
