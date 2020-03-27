# frozen_string_literal: true

module Nmax
  class CLI
    def run
      # require 'pry'
      # binding.pry
      text = STDIN.read
      text.scan(/\d+/).join("\n")
    end
  end
end
