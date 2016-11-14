require 'trollop'

module Rgit
  class Cli
    include Rgit

    SUB_COMMANDS = %w(add-root remove-root show-roots checkout pull fetch status version).freeze

    def initialize(rgit)
      @rgit = rgit
    end

    def parse(args)
      parser = rgit_argument_parser
      global_opts = get_global_options(parser, args)

      @rgit.verbose = global_opts[:verbose]

      cmd = args.shift
      case cmd
        when 'add-root'
          add_root(args)
        when 'remove-root'
          remove_root(args)
        when 'checkout'
          checkout(args)
        when 'show-roots'
          show_roots(args)
        when 'pull'
          pull(args)
        when 'fetch'
          fetch(args)
        when 'status'
          status(args)
        when 'version'
          puts "rgit #{VERSION}"
        else
          puts I18n.t('rgit.unknown_subcommand', command: cmd).red
      end
    end

    private

    def rgit_argument_parser
      Trollop::Parser.new do
        banner I18n.t('rgit.banner')
        opt :verbose, I18n.t('rgit.run_verbosely'), short: '-v'
        stop_on SUB_COMMANDS
      end
    end

    def get_global_options(parser, args)
      Trollop.with_standard_exception_handling parser do
        raise Trollop::HelpNeeded if args.empty?
        parser.parse args
      end
    end

    def register_options_banner(args, banner_text)
      Trollop.options(args) do
        banner banner_text
      end
    end

    def add_root(args)
      register_options_banner(args, I18n.t('add_root.banner'))
      path = args.size == 1 ? args[0] : Dir.pwd
      @rgit.add_root(path)
    end

    def remove_root(args)
      register_options_banner(args, I18n.t('remove_root.banner'))
      path = args.size == 1 ? args[0] : Dir.pwd
      @rgit.remove_root(path)
    end

    def checkout(args)
      register_options_banner(args, I18n.t('checkout.banner'))
      branch = args[0] if args.size == 1
      unless branch
        puts I18n.t('branch.expect_name').red
        return
      end
      @rgit.checkout branch
    end

    def show_roots(args)
      register_options_banner(args, I18n.t('show_roots.banner'))
      @rgit.print_roots
    end

    def pull(args)
      register_options_banner(args, I18n.t('pull.banner'))
      @rgit.pull
    end

    def fetch(args)
      register_options_banner(args, I18n.t('fetch.banner'))
      @rgit.fetch
    end

    def status(args)
      register_options_banner(args, I18n.t('status.banner'))
      @rgit.status
    end
  end
end
