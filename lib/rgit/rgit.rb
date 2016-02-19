require 'rgit/version'
require 'rgit/configuration'
require 'rgit/cli'
require 'optparse'

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

    def pull
      recursive_cmd('pull')
    end

    def fetch
      recursive_cmd('fetch')
    end

    def checkout(branch)
      recursive_cmd("checkout #{branch}")
    end

    def recursive_cmd(command)
      # TODO: Implement
      puts "Exeucte git command: #{command}"
    end
  end
end
