require 'spec_helper'

describe Rgit::Cli do
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
  it 'displays help' do
    expect { Rgit::Cli.parse(['-h']) }.to output(/Usage: r-git/).to_stdout
    expect { Rgit::Cli.parse(['--help']) }.to output(/Usage: r-git/).to_stdout
  end
  it 'displays version' do
    expect { Rgit::Cli.parse(['--version']) }.to output("#{Rgit::VERSION}\n").to_stdout
  end
end
