# frozen_string_literal: true

require 'optparse'
require 'yamlook/version'

module Yamlook
  # Yamlook CLI
  class Cli
    attr_reader :arguments, :options

    def initialize(arguments)
      @arguments = arguments
      @options = {}

      opt_parser.parse!(@arguments)

      show_help! if @arguments.empty?
    rescue OptionParser::InvalidOption => e
      puts e
      exit 1
    end

    def argument
      @arguments.first
    end

    private

    # rubocop:disable Metrics/MethodLength
    def opt_parser
      @opt_parser ||= OptionParser.new do |opts|
        opts.banner = 'Usage: yamlook KEYS'
        opts.separator ''
        opts.separator 'Example: yamlook some.deep.key.in.you.yaml.file'

        opts.separator ''
        opts.separator 'Options:'
        opts.on_tail('-h', '--help', 'Show this message') do
          puts opts.help
          exit
        end

        opts.on_tail('--version', 'Show version') do
          puts Yamlook::VERSION
          exit
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

    def show_help!
      puts opt_parser.help
      exit
    end
  end
end
