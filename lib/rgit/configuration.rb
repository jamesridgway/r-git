require 'yaml'
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
      @roots << path
    end

    def save
      config = {
          roots: @roots
      }
      File.open(@filename, 'w') do |f|
        f.write config.to_yaml
      end
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
