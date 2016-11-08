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

  context 'print roots' do
    it 'no roots exist' do
      config = double('mock config')
      allow(config).to receive(:roots).and_return([])
      rgit = Rgit::Rgit.new(config)
      expect do
        rgit.print_roots
      end.to output("No roots have been configured. Run 'rgit --add-root' to add the current directory as a root\n")
        .to_stdout
    end
    it 'roots exist' do
      config = double('mock config')
      allow(config).to receive(:roots).and_return(['/path/repo1', '/path/repo2'])
      rgit = Rgit::Rgit.new(config)
      expect do
        rgit.print_roots
      end.to output("Roots:\n  - /path/repo1\n  - /path/repo2\n").to_stdout
    end
  end

  context 'root with 2 sample repositories' do
    config = setup_test_root
    it 'checkout branch' do
      git1 = add_mock_repo(config)
      git2 = add_mock_repo(config)
      expect(git1).to receive(:checkout).with('master')
      expect(git2).to receive(:checkout).with('master')
      rgit = Rgit::Rgit.new(config)
      rgit.checkout('master', config.roots[0])
    end
  end

  it 'has a version number' do
    expect(Rgit::VERSION).not_to be nil
  end
end
