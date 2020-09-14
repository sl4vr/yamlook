# frozen_string_literal: true

module Yamlook
  # Yaml file to perform search
  class File
    attr_reader :filename

    def initialize(filename)
      @filename = filename
    end

    def search(keys)
      return unless yaml

      findings = root_node_list.search(keys).flatten.compact.map do |finding|
        finding.filename = filename
        finding
      end

      findings if findings.any?
    end

    def yaml
      @yaml ||= parse_file(filename)
    end

    private

    def parse_file(filename)
      ::Psych.parse_file(filename)
    rescue ::Psych::Exception
      nil
    end

    def root_node_list
      NodeList.new(root_mapping.children)
    end

    def root_mapping
      yaml.children.first
    end
  end
end
