require 'spec_helper'

describe Rgit::Cli do
  it 'displays help' do
    expect { Rgit::Cli.parse(['-h']) }.to output(/Usage: r-git/).to_stdout
    expect { Rgit::Cli.parse(['--help']) }.to output(/Usage: r-git/).to_stdout
  end
  it 'displays version' do
    expect { Rgit::Cli.parse(['--version']) }.to output("#{Rgit::VERSION}\n").to_stdout
  end
end
