# frozen_string_literal: true

module Yamlook
  # Holds information for iteration over Psych::Handler iterating through mappings
  class Iteration
    attr_accessor :active, :offset

    def initialize(active: false, offset: 0)
      @active = active
      @offset = offset
    end

    def reset!
      @active = false
      @offset = 0
    end
  end
end
