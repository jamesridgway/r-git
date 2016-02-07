module Rgit
  class Cli
    def self.parse(args)
      options = {}
      OptionParser.new do |opts|
        opts.banner = 'Usage: r-git [options]'

        opts.on_tail('-h', '--help', 'Show this message') do
          puts opts
          exit
        end
        opts.on_tail('--version', 'Show version') do
          puts Rgit::VERSION
          exit
        end
      end.parse!
    end
  end
end