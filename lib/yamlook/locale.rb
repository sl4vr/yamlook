# frozen_string_literal: true

module Yamlook
  # Possible locale keys handling
  module Locale
    LOCALES_FILEPATH = File.join(File.expand_path('../..', __dir__), 'locales.yaml')
    LOCALES = Psych.load_file(LOCALES_FILEPATH)['locales'].freeze

    module_function

    def key_combinations(keys)
      localized_keys = LOCALES.map { |locale| [locale, *keys] }

      [keys, *localized_keys]
    end
  end
end
