require 'spec_helper'

describe Rgit::Configuration do
  include TestResources

  context 'existing configuration file' do
    config_file = create_temp_file('config_file.yml')

    it 'loads specified config file' do
      config = Rgit::Configuration.load config_file.path
      expect(config.filename).to eq config_file.path
    end

    it 'loads root directories' do
      content_for_file(config_file,
                       "roots:\n"\
                       "  - /path/root1\n"\
                       '  - /mnt/root2')

      config = Rgit::Configuration.load config_file.path
      expect(config.roots).to eq ['/path/root1', '/mnt/root2']
    end
  end

  context 'existing configuration file' do
  end

  context 'empty configuration file' do
    empty_config_file = create_temp_file('empty_config_file.yml')
    new_root = create_temp_dir('new_root')

    it 'has empty roots' do
      config = Rgit::Configuration.load empty_config_file.path
      expect(config.roots).to eq []
    end

    it 'add root configuration file' do
      config = Rgit::Configuration.load empty_config_file.path
      config.add_root(new_root.path)
      expect(config.roots).to eq [new_root.path]
    end
  end
end
