require 'rgit/version'
require 'rgit/configuration'
require 'rgit/cli'
require 'optparse'
require 'git'
require 'colorize'
require 'i18n'
module Rgit
  class Rgit
    attr_accessor :verbose

    def initialize(config)
      @config = config
      @verbose = false
    end

    def add_root(path)
      raise "Not a directory: #{path}" unless File.directory?(path)
      puts I18n.t('add_root.adding_root', path: path)
      @config.add_root path
      @config.save
    end

    def remove_root(path)
      raise "Not a directory: #{path}" unless File.directory?(path)
      puts I18n.t('remove_root.removing_root', path: path)
      @config.remove_root path
      @config.save
    end

    def pull(path = Dir.pwd)
      recursive_cmd(path) do |git|
        git.remotes.each do |remote|
          puts " #{I18n.t('pull.pulling_remote', name: remote.name)}".colorize(:light_cyan)
          results = git.pull(remote.name, git.current_branch)
          puts results.split("\n").map { |l| "   #{l}" }.join("\n") if @verbose
        end
      end
    end

    def fetch(path = Dir.pwd)
      recursive_cmd(path) do |git|
        git.remotes.each do |remote|
          puts " #{I18n.t('fetch.fetching_remote', name: remote.name)}".colorize(:light_cyan)
          results = git.fetch(remote.name, all: true)
          puts results.split("\n").map { |l| "   #{l}" }.join("\n") if @verbose
        end
      end
    end

    def checkout(branch, path = Dir.pwd)
      recursive_cmd(path) do |git|
        puts " #{I18n.t('checkout.checkout_branch', branch: branch)}".colorize(:light_cyan)
        git.checkout branch
      end
    end

    def status(path = Dir.pwd)
      puts path
      recursive_cmd(path) do |git|
        unless git.status.untracked.empty?
          puts " #{I18n.t('status.untracked_changes', branch: git.current_branch)}:".colorize(:light_red)
          git.status.untracked.keys.each { |filename| puts "   - #{filename}" }
        end
        unless git.status.changed.empty?
          puts " #{I18n.t('status.uncommitted_changes', branch: git.current_branch)}:".colorize(:light_magenta)
          git.status.changed.keys.each { |filename| puts "   - #{filename}" }
        end
        if git.status.untracked.empty? && git.status.changed.empty?
          puts " #{I18n.t('status.on_branch', branch: git.current_branch)}".colorize(:green)
        end
      end
    end

    def print_roots
      if @config.roots.empty?
        puts I18n.t('show_roots.no_routes_configured')
      else
        puts "#{I18n.t('roots')}:"
        @config.roots.each do |root|
          puts "  - #{root}"
        end
      end
    end

    private

    def recursive_cmd(path)
      parent_path = @config.find_root(path)
      repositories(parent_path).each do |git|
        repo_name = git.dir.path.gsub("#{path}/", '')
        puts "#{(I18n.t('repository') + ':').colorize(:light_blue)} #{repo_name}"
        begin
          yield git
        rescue Git::GitExecuteError => e
          puts "   #{I18n.t('failed')}:".colorize(:red)
          puts e.message.split("\n").map { |l| "    #{l}" }.join("\n").colorize(:red)
        end
      end
    end

    def repositories(path)
      git_repos = []
      dirs = Dir.entries(path).select do |entry|
        File.directory?(File.join(path, entry)) && !(entry == '.' || entry == '..')
      end.sort
      dirs.each do |dir|
        dir_path = File.join(path, dir)
        if File.exist?(File.join(dir_path, '.git', 'config'))
          git_repos << Git.open(dir_path)
        else
          git_repos.concat repositories(dir_path)
        end
      end
      git_repos
    end
  end
end
