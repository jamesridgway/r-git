$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'test_resources'

# Coverage for rgit
require 'simplecov'
SimpleCov.start
require 'rgit/rgit'
