require "convertkit/collection"
require "convertkit/collections/subscribers"

module Convertkit
  class Collections
    def self.classes
      [Convertkit::Subscribers]
    end
    
    def self.find_class(name)
      self.classes.find { |c| c.collection_name == name } || Convertkit::Collection
    end
    
  end
end