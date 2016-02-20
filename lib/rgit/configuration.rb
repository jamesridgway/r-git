require 'yaml'
require 'fileutils'

module Rgit
  class Configuration
    attr_reader :filename

    def self.exist?(filename = File.join(Dir.home, '.rgit.yml'))
      File.exist?(filename)
    end

    def self.create(filename = File.join(Dir.home, '.rgit.yml'))
      FileUtils.touch(filename)
      config = Configuration.new(filename)
      config.save
      config
    end

    def self.load(filename = File.join(Dir.home, '.rgit.yml'))
      Configuration.new(filename)
    end

    def roots
      @roots.freeze
    end

    def add_root(path)
      raise '"/" path unsupported!' if path == '/'
      @roots << path unless @roots.include? path
    end

    def remove_root(path)
      @roots.delete path
    end

    def save
      config = {
          'roots' => @roots
      }
      File.open(@filename, 'w') do |f|
        f.write config.to_yaml
      end
    end

    def find_root(path)
      until @roots.include?(path)
        path = File.expand_path('..', path)
        raise 'Not in a root directory' if path == '/'
      end
      path
    end

    private

    def initialize(filename)
      @filename = filename
      @roots = []

      return if File.size(filename) == 0

      yaml = YAML.load_file(filename)
      @roots = yaml['roots']
    end

  end
end
