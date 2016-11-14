require 'spec_helper'

describe Rgit::Cli do
  before do
    @rgit = double
    @cli = Rgit::Cli.new(@rgit)
  end
  context 'add root' do
    it 'add root (default to pwd)' do
      expect(@rgit).to receive(:add_root).with(Dir.pwd)
      expect(@rgit).to receive(:verbose=).with(false)

      @cli.parse(['add-root'])
    end
    it 'add root' do
      expect(@rgit).to receive(:add_root).with('/some/path')
      expect(@rgit).to receive(:verbose=).with(false)

      @cli.parse(%w(add-root /some/path))
    end
  end

  context 'remove root' do
    it 'remove root (default to pwd)' do
      expect(@rgit).to receive(:remove_root).with(Dir.pwd)
      expect(@rgit).to receive(:verbose=).with(false)

      @cli.parse(['remove-root'])
    end
    it 'remove root' do
      expect(@rgit).to receive(:remove_root).with('/some/path')
      expect(@rgit).to receive(:verbose=).with(false)

      @cli.parse(%w(remove-root /some/path))
    end
  end

  context 'show roots' do
    it 'show roots invokes print_roots' do
      expect(@rgit).to receive(:print_roots)
      expect(@rgit).to receive(:verbose=).with(false)

      @cli.parse(['show-roots'])
    end
    it 'remove root' do
      expect(@rgit).to receive(:remove_root).with('/some/path')
      expect(@rgit).to receive(:verbose=).with(false)

      @cli.parse(%w(remove-root /some/path))
    end
  end

  context 'git pull' do
    it 'pull' do
      expect(@rgit).to receive(:pull)
      expect(@rgit).to receive(:verbose=).with(false)

      @cli.parse(['pull'])
    end
  end

  context 'git fetch' do
    it 'fetch' do
      expect(@rgit).to receive(:fetch)
      expect(@rgit).to receive(:verbose=).with(false)
      @cli.parse(['fetch'])
    end
  end

  context 'git checkout' do
    it 'checkout development' do
      expect(@rgit).to receive(:checkout).with('development')
      expect(@rgit).to receive(:verbose=).with(false)

      @cli.parse(%w(checkout development))
    end
  end

  context 'git status' do
    it 'status' do
      expect(@rgit).to receive(:status)
      expect(@rgit).to receive(:verbose=).with(false)

      @cli.parse(['status'])
    end
  end

  it 'displays version' do
    expect(@rgit).to receive(:verbose=).with(false)
    expect { @cli.parse(['version']) }.to output("rgit #{Rgit::VERSION}\n").to_stdout
  end
end
