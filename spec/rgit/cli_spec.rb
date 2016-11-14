require 'spec_helper'

describe Rgit::Cli do
  context 'add root' do
    it 'add root (default to pwd)' do
      rgit = double
      expect(rgit).to receive(:add_root).with(Dir.pwd)
      expect(rgit).to receive(:verbose=).with(false)

      Rgit::Cli.parse(['add-root'], rgit)
    end
    it 'add root' do
      rgit = double
      expect(rgit).to receive(:add_root).with('/some/path')
      expect(rgit).to receive(:verbose=).with(false)

      Rgit::Cli.parse(%w(add-root /some/path), rgit)
    end
  end

  context 'remove root' do
    it 'remove root (default to pwd)' do
      rgit = double
      expect(rgit).to receive(:remove_root).with(Dir.pwd)
      expect(rgit).to receive(:verbose=).with(false)

      Rgit::Cli.parse(['remove-root'], rgit)
    end
    it 'remove root' do
      rgit = double
      expect(rgit).to receive(:remove_root).with('/some/path')
      expect(rgit).to receive(:verbose=).with(false)

      Rgit::Cli.parse(%w(remove-root /some/path), rgit)
    end
  end

  context 'show roots' do
    it 'show roots invokes print_roots' do
      rgit = double
      expect(rgit).to receive(:print_roots)
      expect(rgit).to receive(:verbose=).with(false)

      Rgit::Cli.parse(['show-roots'], rgit)
    end
    it 'remove root' do
      rgit = double
      expect(rgit).to receive(:remove_root).with('/some/path')
      expect(rgit).to receive(:verbose=).with(false)

      Rgit::Cli.parse(%w(remove-root /some/path), rgit)
    end
  end

  context 'git pull' do
    it 'pull' do
      rgit = double
      expect(rgit).to receive(:pull)
      expect(rgit).to receive(:verbose=).with(false)

      Rgit::Cli.parse(['pull'], rgit)
    end
  end

  context 'git fetch' do
    it 'fetch' do
      rgit = double
      expect(rgit).to receive(:fetch)
      expect(rgit).to receive(:verbose=).with(false)
      Rgit::Cli.parse(['fetch'], rgit)
    end
  end

  context 'git checkout' do
    it 'checkout development' do
      rgit = double
      expect(rgit).to receive(:checkout).with('development')
      expect(rgit).to receive(:verbose=).with(false)

      Rgit::Cli.parse(%w(checkout development), rgit)
    end
  end

  context 'git status' do
    it 'status' do
      rgit = double
      expect(rgit).to receive(:status)
      expect(rgit).to receive(:verbose=).with(false)

      Rgit::Cli.parse(['status'], rgit)
    end
  end

  it 'displays version' do
    expect { Rgit::Cli.parse(['version']) }.to output("rgit #{Rgit::VERSION}\n").to_stdout
  end
end
