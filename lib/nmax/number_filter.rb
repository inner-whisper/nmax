# frozen_string_literal: true

module Nmax
  # This class is responsible for filtering numbers from text stream
  class NumberFilter
    attr_writer :current_number_string, :numbers_from_text

    def max_numbers_from_io(io:, numbers_count:)
      filter_numbers_from_io(io)

      numbers_from_text.max(numbers_count)
    end

    private

    def filter_numbers_from_io(io)
      io.each_char do |char|
        if integer?(char)
          self.current_number_string = current_number_string + char
        else
          add_current_number_to_array
        end
      end

      add_current_number_to_array
    end

    def current_number_string
      @current_number_string ||= ''
    end

    def numbers_from_text
      @numbers_from_text ||= []
    end

    def integer?(char)
      char.to_i.to_s == char
    end

    def add_current_number_to_array
      return if current_number_string.length.zero?

      numbers_from_text << current_number_string.to_i

      self.current_number_string = ''
    end
  end
end
