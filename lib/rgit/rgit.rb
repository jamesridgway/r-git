require 'rgit/version'
require 'rgit/configuration'
require 'rgit/cli'
require 'optparse'

module Rgit
  class Rgit

    def add_root(path)
      raise "Not a directory: #{path}" unless File.directory?(path)
      puts "Adding root: #{path}"
    end

    def remove_root(path)
      raise "Not a directory: #{path}" unless File.directory?(path)
      puts "Removing root: #{path}"
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
      puts "Exeucte git command: #{command}"
    end

  end
end