require 'simplecov'

SimpleCov.start do
  enable_coverage :branch
  add_filter '/spec/'
  coverage_dir 'coverage'
end

load File.join(File.dirname(__FILE__), '..', 'lib', 'weighted_sample.rb')
