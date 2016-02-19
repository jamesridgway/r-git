require 'spec_helper'

describe Rgit::Configuration do
  include TestResources

  context 'new configuration file' do
    temp_file_path = generate_temp_filename('new_config_file.yml')

    it 'can be created' do
      config = Rgit::Configuration.create(temp_file_path)
      expect(config.roots).to eq []

    end

  end

  context 'existing configuration file' do
    config_file = create_temp_file('config_file.yml')

    it 'detected as existing configuration file' do
      expect(Rgit::Configuration.exist?(config_file.path)).to be true
    end

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

  context 'non-existent configuration file' do
    it 'is detected as not existing' do
      expect(Rgit::Configuration.exist?('some-random-file')).to be false
    end
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
