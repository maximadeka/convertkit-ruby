module Convertkit
  class Configuration
    attr_accessor :api_secret, :api_key
    attr_accessor :timeout, :open_timeout

    def initialize
      @timeout = 30
      @open_timeout = 5
    end
  end
end
