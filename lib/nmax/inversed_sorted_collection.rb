# frozen_string_literal: true

module Nmax
  # This class is responsible for handling sorted array, constrained by length
  class InversedSortedCollection
    attr_reader :array, :length_limit

    # @param array [Array] Array to convert into collection
    # @param length_limit [Integer] soft limit for collection length
    #   (all extra elements will be dropped from collection without warnings or exceptions)
    def initialize(array: [], length_limit:)
      @length_limit = Integer(length_limit)
      @array = Array(array).map { |el| Integer(el) }
                           .sort.reverse.first(@length_limit)
    end

    # Adds number to collection, sort collection and limit it by `length_limit` size
    # @param value [Integer] integer to add into collection
    def <<(value)
      val = Integer(value)

      array.insert(index_to_insert(val), val)

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
