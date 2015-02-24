# -*- encoding: utf-8 -*-
require File.expand_path('../lib/series/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Simon Chiang"]
  gem.email         = ["simon.a.chiang@gmail.com"]
  gem.description   = "Generate series data"
  gem.summary       = "Generate series data"
  gem.homepage      = ""

  gem.files         = []
  gem.executables   = Dir.glob("bin/series*").map {|file| File.basename(file) }
  gem.test_files    = []
  gem.name          = "series"
  gem.require_paths = ["lib"]
  gem.version       = Series::VERSION
end
