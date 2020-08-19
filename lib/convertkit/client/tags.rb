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

      def remove_tag_from_subscriber(tag_id, subscriber_id)
        connection.delete("subscribers/#{subscriber_id}/tags/#{tag_id}")
      end

      def remove_tag_from_subscriber_by_email(tag_id, email)
        connection.post("tags/#{tag_id}/unsubscribe") do |f|
          f.params['email'] = email
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

      def subscriptions_to_tag(tag_id, options = {})
        connection.get("tags/#{tag_id}/subscriptions", options) do |f|
          f.params["page"] = options[:page] if options[:page]
          f.params["sort_order"] = options[:sort_order] if options[:sort_order]
          f.params["subscriber_state"] = options[:subscriber_state] if options[:subscriber_state]
        end
      end
    end
  end
end
