require 'spec_helper'

describe Rgit::Configuration do
  it 'defaults to home directory config file' do
    config = Rgit::Configuration.load
    expect(config.filename).to eq(File.join(Dir.home, '.rgit.yml'))
  end

  it 'loads specified config file' do
    config = Rgit::Configuration.load test_resource('configuration_sample.yml').path
    expect(config.filename).to end_with 'configuration_sample.yml'
  end

  it 'loads root directories' do
    config = Rgit::Configuration.load test_resource('configuration_sample.yml').path
    expect(config.roots).to eq ['/path/root1', '/mnt/root2']
  end

  it 'empty roots for a config file that does not exist' do
    config = Rgit::Configuration.load 'config_file_that_does_not_exist.yml'
    expect(config.roots).to eq []
  end
end
