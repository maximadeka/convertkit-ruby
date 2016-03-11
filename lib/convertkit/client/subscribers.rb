require "cgi"

module Convertkit
  class Client
    module Subscribers
      def subscribers(options = {})
        get "subscribers", options
      end
    end
  end
end