module Rgit
  class Cli
    include Rgit
    def self.parse(args, rgit = Rgit.new(Configuration.exist? ? Configuration.load : Configuration.create))
      OptionParser.new do |opts|
        opts.banner = 'Usage: r-git [options]'
        opts.on('--add-root [PATH]', 'Add a root directory (defaults to pwd).') do |root_path|
          rgit.add_root(root_path.nil? ? Dir.pwd : root_path)
        end
        opts.on('--remove-root [PATH]', 'Remove a root directory (defaults to pwd).') do |root_path|
          rgit.remove_root(root_path.nil? ? Dir.pwd : root_path)
        end
        opts.on_tail('-h', '--help', 'Show this message') do
          puts opts
        end
        opts.on_tail('--version', 'Show version') do
          puts VERSION
        end
      end.parse!(args)
    end
  end
end
