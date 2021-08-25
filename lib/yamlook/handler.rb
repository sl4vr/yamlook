# frozen_string_literal: true

require 'psych'

module Yamlook
  # Handler for Psych::Parser
  class Handler < ::Psych::Handler
    attr_reader :found

    def initialize(keys:, locales: [])
      super()
      @keys = keys
      @locales = locales
      @found = []

      @iterations = []
      @current_iteration = Iteration.new(active: true)
    end

    def event_location(start_line, start_column, _end_line, _end_column)
      @start_line = start_line
      @start_column = start_column
    end

    def start_mapping(_anchor, _tag, _implicit, _style)
      @iterations.push(@current_iteration.dup)
      @current_iteration.reset!
    end

    def end_mapping
      @iterations.pop
      @current_iteration.reset!
    end

    def scalar(value, _anchor, _tag, _plain, _quoted, _style) # rubocop:disable Metrics/ParameterLists
      @found << [value, @start_line.next, @start_column.next] if keys_out? && all_active?

      refresh_current_interation!(value)
    end

    def refresh_current_interation!(value)
      value_keys = value.split(SEPARATOR)

      value_keys.shift if current_offset.zero? && LOCALES.include?(value_keys.first)

      @current_iteration.offset = value_keys.count
      @current_iteration.active = current_keys == value_keys
    end

    def current_offset
      @iterations.sum(&:offset)
    end

    def current_keys
      @keys.drop(current_offset).take(@current_iteration.offset)
    end

    def keys_out?
      current_offset + @current_iteration.offset == @keys.size
    end

    def all_active?
      @iterations.any? && @iterations.all?(&:active) && @current_iteration.active
    end
  end
end
