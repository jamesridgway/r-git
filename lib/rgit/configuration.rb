require 'yaml'
module Rgit
  class Configuration
    attr_reader :filename

    def self.load(filename = File.join(Dir.home, '.rgit.yml'))
      Configuration.new(filename)
    end

    def roots
      @roots ? @roots : []
    end

    private

    def initialize(filename)
      @filename = filename
      return unless File.exist?(@filename)

      yaml = YAML.load_file(filename)
      @roots = yaml['roots'].freeze
    end
  end
end
