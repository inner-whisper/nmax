# frozen_string_literal: true

module Nmax
  # This class is responsible for filtering numbers from text stream
  class NumberFilter
    attr_writer :current_number_string
    attr_reader :numbers_from_text

    def max_numbers_from_io(io:, numbers_count:)
      @numbers_from_text = InversedSortedCollection.new(length_limit: numbers_count)

      filter_numbers_from_io(io)

      numbers_from_text.array
    end

    private

    def filter_numbers_from_io(io)
      # это работает быстрее на маленьких файлах, тест:
      # time bash -c 'cat /Users/innerwhisper/Projects/itpard/theater_tickets/log/test.log | bundle exec exe/nmax 1000'
      # io.read.scan(/\d+/) { |w| numbers_from_text << w.to_i }

      prev_number = nil
      chunk_number = nil

      io.each(1000) do |chunk|
        chunk.scan(/\d+/) do |number|
          # numbers_from_text << number.to_i

          unless chunk_number.nil?
            number += chunk_number
            chunk_number = nil
          end

          unless prev_number.nil?
            numbers_from_text << prev_number.to_i
          end

          prev_number = number
        end

        if integer?(chunk[-1])
          chunk_number = prev_number
        else
          numbers_from_text << prev_number.to_i
          prev_number = nil
          chunk_number = nil
        end
      end

      unless prev_number.nil?
        numbers_from_text << prev_number.to_i
      end

      # io.each_char do |char|
      #   if integer?(char)
      #     self.current_number_string = current_number_string + char
      #   else
      #     add_current_number_to_array
      #   end
      # end

      # add_current_number_to_array
    end

    def current_number_string
      @current_number_string ||= ''
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
