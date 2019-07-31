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

      def create_tag(tag_name)
        response = connection.post("tags") do |request|
          request.params["tag"] = { name: tag_name }
        end
        response.body
      end

      def create_tags(tag_names)
        response = connection.post("tags") do |request|
          request.params["tag"] = tag_names.map { |tag_name| { name: tag_name } }
        end
        response.body
      end
    end
  end
end
