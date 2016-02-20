require 'rgit/version'
require 'rgit/configuration'
require 'rgit/cli'
require 'optparse'
require 'git'
require 'colorize'
module Rgit
  class Rgit

    def initialize(config)
      @config = config
    end

    def add_root(path)
      raise "Not a directory: #{path}" unless File.directory?(path)
      puts "Adding root: #{path}"
      @config.add_root path
      @config.save
    end

    def remove_root(path)
      raise "Not a directory: #{path}" unless File.directory?(path)
      puts "Removing root: #{path}"
      @config.remove_root path
      @config.save
    end

    def pull(path = Dir.pwd)
      recursive_cmd(path) do |git|
        git.remotes.each do | remote|
          puts " Pulling remote: #{remote.name}".colorize(:light_cyan)
          results = git.pull(remote.name, git.current_branch)
          puts results.split("\n").map {|l| "   #{l}"}.join("\n")
        end
      end
    end

    def fetch(path = Dir.pwd)
      recursive_cmd(path) do |git|
        git.remotes.each do | remote|
          puts " Fetching remote: #{remote.name}".colorize(:light_cyan)
          results = git.fetch(remote.name, all: true)
          puts results.split("\n").map {|l| "   #{l}"}.join("\n")
        end
      end
    end

    def checkout(branch, path = Dir.pwd)
      recursive_cmd(path) do |git|
        puts " Checkout branch: #{branch}".colorize(:light_cyan)
        git.checkout branch
      end
    end

    def status(path = Dir.pwd)
      recursive_cmd(path) do |git|
        unless git.status.untracked.empty?
          puts " Untracked changes (#{git.current_branch}):".colorize(:light_red)
          git.status.untracked.keys.each {|filename| puts "   - #{filename}" }
        end
        unless git.status.changed.empty?
          puts " Uncommitted changes (#{git.current_branch}):".colorize(:light_magenta)
          git.status.changed.keys.each {|filename| puts "   - #{filename}" }
        end
        if git.status.untracked.empty? && git.status.changed.empty?
          puts " On branch: #{git.current_branch}".colorize(:green)
        end
      end
    end

    private

    def recursive_cmd(path, &block)
      parent_path = @config.find_root(path)
      repositories(parent_path).each do |git|
        repo_name = git.dir.path.gsub("#{path}/", '')
        puts "#{'Repository:'.colorize(:light_blue)} #{repo_name}"
        begin
          yield git
        rescue Git::GitExecuteError => e
          puts "   Failed:".colorize(:red)
          puts e.message.split("\n").map {|l| "    #{l}"}.join("\n").colorize(:red)
        end
      end
    end

    def repositories(path)
      git_repos = []
      dirs = Dir.entries(path).select{ |entry| File.directory?(File.join(path, entry)) && !(entry == '.' || entry == '..') }.sort
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
