module Convertkit
  class Client
    module Subscribers
      def subscribers(options = {})
        connection.get("subscribers", options)
      end

      def subscriber(subscriber_id)
        connection.get("subscribers/#{subscriber_id}")
      end

      def unsubscribe(email)
        connection.put("unsubscribe") do |f|
          f.params['email'] = email
        end
      end
    end
  end
end
