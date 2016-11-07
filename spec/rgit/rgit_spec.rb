require 'spec_helper'

describe Rgit do
  include TestResources

  context 'directory does not exist' do
    it 'error when adding as root' do
      config = double('mock config')
      rgit = Rgit::Rgit.new(config)
      expect { rgit.add_root('some-non-existent-path') }.to raise_error('Not a directory: some-non-existent-path')
    end

    it 'error when removing as root' do
      config = double('mock config')
      rgit = Rgit::Rgit.new(config)
      expect { rgit.remove_root('some-non-existent-path') }.to raise_error('Not a directory: some-non-existent-path')
    end
  end

  context 'directory exists' do
    parent_folder = create_temp_dir('parent_folder')

    it 'root added' do
      config = double('mock config')
      expect(config).to receive(:add_root).with(parent_folder.path)
      expect(config).to receive(:save)

      rgit = Rgit::Rgit.new(config)
      rgit.add_root(parent_folder.path)
    end

    it 'root removed' do
      config = double('mock config')
      expect(config).to receive(:remove_root).with(parent_folder.path)
      expect(config).to receive(:save)

      rgit = Rgit::Rgit.new(config)
      rgit.remove_root(parent_folder.path)
    end
  end

  it 'has a version number' do
    expect(Rgit::VERSION).not_to be nil
  end
end
