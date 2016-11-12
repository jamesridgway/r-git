require 'trollop'

module Rgit
  class Cli
    include Rgit

    SUB_COMMANDS = %w(add-root remove-root show-roots checkout pull fetch status version).freeze

    def self.parse(args, rgit = Rgit.new(Configuration.exist? ? Configuration.load : Configuration.create))
      global_opts = Trollop.options(args) do
        banner I18n.t('rgit.banner')
        opt :verbose, 'Run verbosely', short: '-v'
        stop_on SUB_COMMANDS
      end

      rgit.verbose = global_opts[:verbose]

      cmd = args.shift
      case cmd
        when 'add-root'
          path = args.size == 1 ? args[0] : Dir.pwd
          rgit.add_root(path)
        when 'remove-root'
          path = args.size == 1 ? args[0] : Dir.pwd
          rgit.remove_root(path)
        when 'checkout'
          branch = args[0] if args.size == 1
          unless branch
            puts 'ERROR: checkout subcommand expects a branch name'.red
            return
          end
          rgit.checkout branch
        when 'show-root'
          rgit.print_roots
        when 'pull'
          rgit.pull
        when 'fetch'
          rgit.fetch
        when 'status'
          rgit.status
        when 'version'
          puts "rgit #{VERSION}"
        else
          puts "ERROR: unknown subcommand #{cmd}".red
          return
      end
    end
  end
end
