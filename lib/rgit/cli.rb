module Rgit
  class Cli
    include Rgit
    def self.parse(args, rgit = Rgit.new(Configuration.exist? ? Configuration.load : Configuration.create))
      OptionParser.new do |opts|
        opts.banner = 'Usage: rgit [options]'
        opts.on('--add-root [PATH]', 'Add a root directory (defaults to pwd).') do |root_path|
          rgit.add_root(root_path.nil? ? Dir.pwd : root_path)
        end
        opts.on('--remove-root [PATH]', 'Remove a root directory (defaults to pwd).') do |root_path|
          rgit.remove_root(root_path.nil? ? Dir.pwd : root_path)
        end
        opts.on('-p', '--pull', 'Git pull') do
          rgit.pull
        end
        opts.on('-f', '--fetch', 'Git fetch') do
          rgit.fetch
        end
        opts.on('-c', '--checkout BRANCH', 'Git checkout') do |branch|
          rgit.checkout branch
        end
        opts.on('-s', '--status', 'Git status') do
          rgit.status
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
