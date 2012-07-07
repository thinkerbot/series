# -*- encoding: utf-8 -*-
require File.expand_path('../lib/series/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Simon Chiang"]
  gem.email         = ["simon.a.chiang@gmail.com"]
  gem.description   = %w{
    The series gem provides tools to generate series data from the command line or
    in a script using a pluggable architecture (meaning you can add your own
    series generators easily).
  }.join(' ')
  gem.summary       = "Generate series data"
  gem.homepage      = ""

  gem.files         = []
  gem.executables   = ['series']
  gem.test_files    = []
  gem.name          = "series"
  gem.require_paths = ["lib"]
  gem.version       = Series::VERSION

  gem.add_development_dependency('rake', '~> 0.9.2')
  gem.add_development_dependency('bundler', '~> 1.0')
  gem.add_development_dependency('rdoc', '~> 3.9')
  gem.add_development_dependency('shell_test', '~> 0.5')
end
