$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'test_resources'
require 'i18n'

I18n.load_path << File.expand_path('../../locales/en.yml', __FILE__)
I18n.reload!

# Coverage for rgit
require 'simplecov'
SimpleCov.start
require 'rgit/rgit'
