# frozen_string_literal: true

module Nmax
  # This class is responsible for filtering numbers from text stream
  class NumberFilter
    def max_numbers_from_io(io:, numbers_count:)
      text = io.read
      numbers_from_text = text.scan(/\d+/).map(&:to_i)
      numbers_from_text.max(numbers_count)
    end
  end
end
