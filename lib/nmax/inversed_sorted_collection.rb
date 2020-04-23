# frozen_string_literal: true

module Nmax
  # This class is responsible for handling constrained by length sorted array
  class InversedSortedCollection
    attr_reader :array, :length_limit

    def initialize(array:, length_limit:)
      @length_limit = length_limit
      @array = array.sort.reverse.first(length_limit)
    end

    def <<(value)
      insert_value_in_array(value)

      array.pop if array.size > length_limit
    end

    private

    def insert_value_in_array(value)
      if value >= array.first
        array.unshift(value)
      elsif value <= array.last
        array << value
      else
        index = array.bsearch_index { |el| el <= value }

        array.insert(index, value)
      end
    end
  end
end
