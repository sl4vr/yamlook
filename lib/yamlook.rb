# frozen_string_literal: true

require 'psych'

require 'yamlook/iteration'
require 'yamlook/handler'
require 'yamlook/file'
require 'yamlook/search'
require 'yamlook/cli'

module Yamlook
  SEPARATOR = '.'
  LOCALES_FILEPATH = ::File.join(::File.expand_path('..', __dir__), 'locales.yaml')
  LOCALES = Psych.load_file(LOCALES_FILEPATH)['locales'].freeze
end
