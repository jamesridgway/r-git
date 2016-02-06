$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

def test_resource(filename)
  File.open(File.join(File.dirname(__FILE__), 'resources', filename))
end

require 'simplecov'
SimpleCov.start
require 'rgit/rgit'
