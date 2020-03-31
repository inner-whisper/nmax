# frozen_string_literal: true

module Nmax
  # This class is responsible for command line interface logic
  class CLI
    def run
      text = STDIN.read
      text.scan(/\d+/).join("\n")
    end
  end
end
