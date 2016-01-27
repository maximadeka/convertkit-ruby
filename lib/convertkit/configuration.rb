module Convertkit
  class Configuration
    attr_accessor :api_secret, :api_key
    
    def initialize
      @api_secret = "api_secret"
      @api_key = "api_key"
    end
  end
end