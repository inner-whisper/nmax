# frozen_string_literal: true

module Nmax
  # This class is responsible for handling sorted array, constrained by length
  class InversedSortedCollection
    attr_reader :array, :length_limit

    def initialize(array: [], length_limit:)
      @length_limit = length_limit
      @array = array.sort.reverse.first(length_limit)
    end

    def <<(value)
      array.insert(index_to_insert(value), value)

      array.pop if array.size > length_limit
    end

    private

    def index_to_insert(value)
      if array.empty? || value <= array.last
        -1
      elsif value >= array.first
        0
      else
        array.bsearch_index { |el| el <= value }
      end
    end
  end
end
