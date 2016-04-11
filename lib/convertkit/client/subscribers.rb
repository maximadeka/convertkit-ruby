require "cgi"
require "convertkit/client"

module Convertkit
  class Client
    module Subscribers
      def subscribers(options = {})
        connection.get("subscribers", options)
      end

      def subscriber(subscriber_id)
      	connection.get("subscribers/#{CGI.escape subscriber_id}")
      end

      # def create_subscriber(email, options = {})
      	
      # end
    end
  end
end