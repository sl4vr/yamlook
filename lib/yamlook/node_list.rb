# frozen_string_literal: true

module Yamlook
  Mapping = ::Psych::Nodes::Mapping
  Scalar = ::Psych::Nodes::Scalar

  # List of yaml nodes
  class NodeList
    attr_reader :nodes

    def initialize(nodes)
      @nodes = nodes
    end

    def search(keys)
      keys.map.with_index do |_, index|
        key = keys[0..index].join('.')
        rest_keys = keys[index + 1..-1]

        result = find(key)

        case result
        when NodeList then result.search(rest_keys)
        when Scalar then Node.from_scalar(result)
        end
      end
    end

    private

    def find(key)
      scalar_index = find_scalar_index(key)
      return unless scalar_index

      result = nodes[scalar_index + 1]
      return NodeList.new(result.children) if result.is_a?(Mapping)

      result
    end

    def find_scalar_index(key)
      nodes.find_index { |node| node.is_a?(Scalar) && node.value == key }
    end
  end
end
