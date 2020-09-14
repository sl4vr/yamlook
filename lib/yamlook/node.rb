# frozen_string_literal: true

module Yamlook
  # Result of search - scalar node
  class Node
    attr_reader :value, :line, :column
    attr_accessor :filename

    def initialize(value:, line:, column:, filename: nil)
      @value = value
      @line = line
      @column = column
      @filename = filename
    end

    def self.from_scalar(scalar)
      return unless scalar

      new(
        value: scalar.value,
        line: scalar.start_line + 1,
        column: scalar.start_column + 1
      )
    end

    def to_s
      "#{filename}:#{line}:#{column}\n#{value}"
    end
  end
end
