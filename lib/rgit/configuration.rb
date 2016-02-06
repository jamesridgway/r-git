module Rgit
  class Configuration
    def self.load(filename)
      Configuration.new(filename)
    end

    private

    def initialize(filename)
    end
  end
end
