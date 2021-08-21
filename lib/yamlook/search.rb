# frozen_string_literal: true

module Yamlook
  # Searches for occurrences of dot-notated keys in all yaml files
  # of current directory
  module Search
    NoArgumentsError = Class.new(ArgumentError)

    EXTENSIONS = %w[yml yaml].freeze
    PATTERN = EXTENSIONS.map { |ext| ::File.join('**', "*.#{ext}") }.freeze

    module_function

    def perform(keys)
      raise NoArgumentsError, "Nothing to search for.\n" if keys.empty?

      findings = Dir.glob(PATTERN).map do |filename|
        result = File.new(filename).search(keys)
        print_progress(result)
        result
      end

      print_result(findings.compact)
    rescue NoArgumentsError => e
      puts e.message
    end

    def print_progress(result)
      print result ? "\033[32m*\033[0m" : "\033[33m.\033[0m"
    end

    def print_result(findings)
      puts
      puts '-' * 10
      findings.any? ? print_success(findings) : print_failure
    end

    def print_failure
      puts 'Nothing found.'
    end

    def print_success(findings)
      print "Found #{findings.count} occurrences:"
      findings.each do |finding|
        puts
        puts finding
      end
    end
  end
end
