require 'psych'

module Yamlook
  # Handler for Psych::Parser
  class Handler < ::Psych::Handler
    attr_reader :found
  
    def initialize(keys:, locales: [])
      @keys = keys
      @locales = locales
      @found = []
      @level = -1
      @active = @prev_active = @locale_active = false
      @start_line = @start_column = nil
      @offset = 0
    end
  
    def event_location(start_line, start_column, _end_line, _end_column)
      @start_line = start_line
      @start_column = start_column
    end
  
    def start_mapping(_anchor, _tag, _implicit, _style)
      @level += 1
      @prev_active = @active || top_level?
      @active = false
    end
  
    def end_mapping
      @level -= 1
      @level -= @offset
      @offset = 0
      @locale_active = false if top_level?
    end
  
    def scalar(value, _anchor, _tag, _plain, _quoted, _style)
      if current_level == @keys.size.pred && @active && (current_level.zero? || @prev_active)
        @found << [value, @start_line.next, @start_column.next]
      end

      @active, @offset = match(value)
      @level += @offset
      @locale_active ||= top_level? && @locales.include?(value)
    end
  
    def top_level?
      @level.zero?
    end
  
    def current_level
      @locale_active ? @level.pred : @level
    end

    def match(value)
      return [false, 0] unless @keys[current_level]

      @keys[current_level..-1].each_with_index do |key, index|
        if value == @keys[current_level..index+current_level].join('.')
          return [true, index] 
        end
      end

      [false, 0]
    end
  end
end