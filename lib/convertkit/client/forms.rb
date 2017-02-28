module Convertkit
  class Client
    module Forms
      def forms
        connection.get("forms").body["forms"]
      end

      def add_subscriber_to_form(form_id, email, options = {})
        connection.post("forms/#{form_id}/subscribe") do |f|
          f.params['email'] = email
          f.params['first_name'] = options[:first_name]
          f.params['fields'] = options[:fields]
          f.params['tags'] = options[:tags]
        end
      end
    end
  end
end
