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

      def remove_tag_from_subscriber(subscriber_id, tag_id)
        connection.delete("subscribers/#{subscriber_id}/tags/#{tag_id}")
      end
    end
  end
end
