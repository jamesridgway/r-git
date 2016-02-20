require 'spec_helper'

describe Rgit::Cli do
  context 'add root' do
    it 'add root (default to pwd)' do
      rgit = double
      expect(rgit).to receive(:add_root).with(Dir.pwd)

      Rgit::Cli.parse(['--add-root'], rgit)
    end
    it 'add root' do
      rgit = double
      expect(rgit).to receive(:add_root).with('/some/path')

      Rgit::Cli.parse(['--add-root', '/some/path'], rgit)
    end
  end
  context 'remove root' do
    it 'remove root (default to pwd)' do
      rgit = double
      expect(rgit).to receive(:remove_root).with(Dir.pwd)

      Rgit::Cli.parse(['--remove-root'], rgit)
    end
    it 'remove root' do
      rgit = double
      expect(rgit).to receive(:remove_root).with('/some/path')

      Rgit::Cli.parse(['--remove-root', '/some/path'], rgit)
    end
  end

  context 'git pull' do
    it '-p' do
      rgit = double
      expect(rgit).to receive(:pull)
      Rgit::Cli.parse(['-p'], rgit)
    end
    it '--pull' do
      rgit = double
      expect(rgit).to receive(:pull)
      Rgit::Cli.parse(['--pull'], rgit)
    end
  end

  context 'git fetch' do
    it '-f' do
      rgit = double
      expect(rgit).to receive(:fetch)
      Rgit::Cli.parse(['-f'], rgit)
    end
    it '--fetch' do
      rgit = double
      expect(rgit).to receive(:fetch)
      Rgit::Cli.parse(['--fetch'], rgit)
    end
  end

  context 'git checkout' do
    it '-c development' do
      rgit = double
      expect(rgit).to receive(:checkout).with('development')
      Rgit::Cli.parse(['-c', 'development'], rgit)
    end
    it '--checkout development' do
      rgit = double
      expect(rgit).to receive(:checkout).with('development')
      Rgit::Cli.parse(['--checkout', 'development'], rgit)
    end
  end

  context 'git status' do
    it '-s' do
      rgit = double
      expect(rgit).to receive(:status)
      Rgit::Cli.parse(['-s'], rgit)
    end
    it '--status' do
      rgit = double
      expect(rgit).to receive(:status)
      Rgit::Cli.parse(['--status'], rgit)
    end
  end

  context 'help' do
    it '-h' do
      expect { Rgit::Cli.parse(['-h']) }.to output(/Usage: rgit/).to_stdout
    end
    it '--help' do
      expect { Rgit::Cli.parse(['--help']) }.to output(/Usage: rgit/).to_stdout
    end
  end

  it 'displays version' do
    expect { Rgit::Cli.parse(['--version']) }.to output("#{Rgit::VERSION}\n").to_stdout
  end
end
