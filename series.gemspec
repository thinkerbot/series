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
  gem.executables   = []
  gem.test_files    = []
  gem.name          = "series"
  gem.require_paths = ["lib"]
  gem.version       = Series::VERSION
end
