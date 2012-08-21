# -*- encoding: utf-8 -*-
require File.expand_path('../lib/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["todesking"]
  gem.email         = ["discommunicative@gmail.com"]
  gem.summary       = %q{This gem add Enumerable#weighted_sample_by method.}
  gem.homepage      = "https://github.com/todesking/weighted_sample"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "weighted_sample"
  gem.require_paths = ["lib"]
  gem.version       = WeightedSample::VERSION

  gem.add_development_dependency 'rspec'
end
