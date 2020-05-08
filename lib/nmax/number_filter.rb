# frozen_string_literal: true

module Nmax
  # This class is responsible for filtering numbers from text stream
  class NumberFilter
    BUFFER_SIZE = 1000

    attr_reader :numbers_from_text
    attr_accessor :previous_number, :previous_chunk_buffer

    def max_numbers_from_io(io:, numbers_count:)
      @numbers_from_text = InversedSortedCollection.new(length_limit: numbers_count)

      filter_numbers_from_io(io)

      numbers_from_text.array
    end

    private

    def filter_numbers_from_io(io)
      # time bash -c 'cat /Users/innerwhisper/Projects/itpard/theater_tickets/log/test.log | bundle exec exe/nmax 1000'

      # 13.59s - самый быстрый способ, но выгружает весь файл целиком в RAM
      # io.read.scan(/\d+/) { |w| numbers_from_text << w.to_i }

      # 16.89s - возможный потолок для оптимизации для IO.each
      # io.each(1000000000000000000) { |chunk| chunk.scan(/\d+/) { |number| numbers_from_text << number.to_i } }

      # 22.76s
      io.each(BUFFER_SIZE) do |chunk|
        handle_chunk(chunk)
      end

      numbers_from_text << previous_chunk_buffer.to_i unless previous_chunk_buffer.nil?
    end

    def handle_chunk(chunk)
      handle_previous_chunk_buffer(chunk)

      chunk.scan(/\d+/) do |number|
        handle_prev_number(number)
      end

      handle_end_of_chunk(chunk)
    end

    def handle_previous_chunk_buffer(chunk)
      return if integer?(chunk[0])

      self.previous_number = previous_chunk_buffer
      self.previous_chunk_buffer = nil
    end

    def handle_prev_number(number)
      unless previous_chunk_buffer.nil?
        number = previous_chunk_buffer + number
        self.previous_chunk_buffer = nil
      end

      add_prev_number_to_array unless previous_number.nil?

      self.previous_number = number
    end

    def handle_end_of_chunk(chunk)
      if integer?(chunk[-1])
        self.previous_chunk_buffer = previous_number
      else
        add_prev_number_to_array
      end

      self.previous_number = nil
    end

    def add_prev_number_to_array
      numbers_from_text << previous_number.to_i
    end

    def integer?(char)
      char.to_i.to_s == char
    end
  end
end
