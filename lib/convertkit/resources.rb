require "convertkit/resource"

module Convertkit
  class Resources
    def self.classes
      []
    end
    
    def self.find_class(name)
      self.classes.find { |c| c.resource_name == name } || Convertkit::Resource
    end
  end
end