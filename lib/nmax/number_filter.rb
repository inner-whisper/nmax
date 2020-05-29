# frozen_string_literal: true

module Nmax
  # This class is responsible for filtering numbers from text stream
  class NumberFilter
    # Size in chars of IO reading buffer
    BUFFER_SIZE = 1000
    # Regexp for filtering digits, limited by 1000 symbols (as described in requirements)
    SCANNING_DIGITS_REGEXP = /\d{1,1000}/.freeze

    # Filters input IO object and returns sorted array of biggest numbers from it
    #
    # @param io [IO] IO object to filter
    # @param numbers_count [Integer] size of the output array
    # @return [Array] biggest numbers from IO in sorted order
    def max_numbers_from_io(io:, numbers_count:)
      @numbers_from_text = InversedSortedCollection.new(length_limit: numbers_count)

      filter_numbers_from_io(io)

      numbers_from_text.array
    end

    private

    attr_reader :numbers_from_text
    attr_accessor :previous_number, :previous_chunk_buffer

    # Немного о производительности данного метода
    # Данные о времени приведены с использованием следующего бенчмарка
    # time bash -c 'cat /path/to/test/file | bundle exec exe/nmax 1000'
    #
    # Самый быстрый способ, но выгружает весь файл целиком в RAM
    # 13.59s - 300 Mb file
    # io.read.scan(/\d+/) { |w| numbers_from_text << w.to_i }
    #
    # Возможный потолок для оптимизации для IO.each
    # (можно рассмотреть, если входящий поток точно разбит на строки)
    # 16.89s - 300 Mb file
    # 1497s - 20GB file
    # io.each(1000000) { |chunk| chunk.scan(/\d+/) { |number| numbers_from_text << number.to_i } }
    #
    # Текущая реализация
    # 22.76s - 300 Mb file
    # 2080s - 20 GB file
    def filter_numbers_from_io(io)
      io.each(BUFFER_SIZE) do |chunk|
        handle_chunk(chunk)
      end

      add_value_to_numbers_from_text(previous_chunk_buffer)
    end

    def handle_chunk(chunk)
      handle_previous_chunk_buffer(chunk)

      chunk.scan(SCANNING_DIGITS_REGEXP) do |number|
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

      add_prev_number_to_array

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
      add_value_to_numbers_from_text(previous_number)
    end

    def add_value_to_numbers_from_text(value)
      return if value.nil?

      numbers_from_text << value
    end

    def integer?(char)
      # Данный способ выбран как оптимальный на основании https://stackoverflow.com/a/19849955
      char.to_i.to_s == char
    end
  end
end
