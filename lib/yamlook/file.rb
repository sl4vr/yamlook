# frozen_string_literal: true

module Yamlook
  # Yaml file to perform search
  class File
    attr_reader :filename

    def initialize(filename)
      @filename = filename
    end

    def search(keys)
      file = ::File.read(filename)
      handler = Handler.new(keys: keys, locales: LOCALES)
      parser = ::Psych::Parser.new(handler)

      findings = parser.parse(file).handler.found.map do |value, line, column|
        "#{filename}:#{line}:#{column}\n#{value}"
      end

      findings if findings.any?
    rescue ::Psych::Exception
      nil
    end
  end
end
