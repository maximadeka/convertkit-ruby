module Convertkit
  class Client
    module Tags
      def tags
        connection.get("tags")
      end

      def add_subscriber_to_tag(tag_id, email, options = {})
        connection.post("tags/#{tag_id}/subscribe") do |f|
          f.params['email'] = email
          f.params['first_name'] = options[:first_name]
          f.params['fields'] = options[:fields]
          f.params['tags'] = options[:tags]
        end
      end
    end
  end
end
