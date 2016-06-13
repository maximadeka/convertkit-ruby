module Convertkit
  class Configuration
    attr_accessor :api_secret, :api_key

    def initialize
      @api_secret = nil
      @api_key = nil
    end
  end
end
