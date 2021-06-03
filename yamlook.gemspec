# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'yamlook/version'

Gem::Specification.new do |s|
  s.name = 'yamlook'
  s.version = Yamlook::VERSION
  s.summary = 'Search occurrences of dot-notated yaml keys.'
  s.homepage = 'https://github.com/sl4vr/yamlook'
  s.licenses = ['MIT']
  s.authors = ['Viacheslav Mefodin']
  s.email = ['mefodin.v@gmail.com']

  s.bindir = 'bin'
  s.executables = ['yamlook']
  s.extra_rdoc_files = ['LICENSE.txt', 'README.md']
  s.files = `git ls-files bin lib LICENSE.txt README.md locales.yaml`.split($RS)

  s.required_ruby_version = Gem::Requirement.new('>= 2.4.0')
  s.rubygems_version = '2.5.1'
  s.required_rubygems_version = Gem::Requirement.new('>= 0')

  s.add_runtime_dependency('psych', '~> 3.0')
  s.add_development_dependency('bundler', '>= 1.15.0', '< 3.0')
  s.add_development_dependency('minitest', '>= 5.8')
end
