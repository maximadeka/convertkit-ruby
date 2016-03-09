require "convertkit/collection"

module Convertkit
  class Subscribers < Collection
    def self.collection_name
      "subscribers"
    end
    
    def self.resource_name
      "subscriber"
    end
  end
end