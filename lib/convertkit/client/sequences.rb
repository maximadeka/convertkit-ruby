module Convertkit
  class Client
    module Sequences
      def sequences
        connection.get("sequences")
      end

      def sequence_subscriptions(sequence_id, options = {})
        connection.get("sequences/#{sequence_id}/subscriptions", options)
      end      
      
      def add_subscriber_to_sequence(sequence_id, email, options = {})
        connection.post("sequences/#{sequence_id}/subscribe") do |f|
          f.params['email'] = email
          f.params['first_name'] = options[:first_name]
          f.params['fields'] = options[:fields]
          f.params['tags'] = options[:tags]
        end
      end
    end
  end
end
