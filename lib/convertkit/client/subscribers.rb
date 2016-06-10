module Convertkit
  class Client
    module Subscribers
      def subscribers(options = {})
        connection.get("subscribers", options)
      end

      def subscriber(subscriber_id)
        connection.get("subscribers/#{subscriber_id}")
      end
    end
  end
end
