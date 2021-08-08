# frozen_string_literal: true

module Yamlook
  Mapping = ::Psych::Nodes::Mapping
  Scalar = ::Psych::Nodes::Scalar

  # List of yaml nodes
  class NodeList
    attr_reader :nodes

    def self.from_mapping(mapping)
      new(mapping.children)
    end

    def initialize(nodes)
      @nodes = nodes
    end

    def search(keys)
      return [] unless nodes

      keys.each_index.map do |index|
        key = keys[0..index].join('.')
        rest_keys = keys[index + 1..-1]
        result = find(key)

        case result
        when Mapping then NodeList.from_mapping(result).search(rest_keys)
        when Scalar then Node.from_scalar(result) if rest_keys.empty?
        end
      end
    end

    private

    def find(key)
      key_node_index = find_key_node_index(key)
      nodes[key_node_index + 1] if key_node_index
    end

    def find_key_node_index(key)
      nodes.find_index { |node| node.is_a?(Scalar) && node.value == key }
    end
  end
end
