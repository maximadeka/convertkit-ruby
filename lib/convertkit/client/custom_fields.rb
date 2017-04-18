module Convertkit
  class Client
    module CustomFields

      def custom_fields
        connection.get("custom_fields").body["custom_fields"]
      end

      def add_custom_field(options = {})
        connection.post("custom_fields") do |f|
          f.params['label'] = options[:label]
        end
      end

      def delete_custom_field(custom_field_id)
        connection.delete("custom_fields/#{custom_field_id}")
      end

      def update_custom_field(custom_field_id, options = {})
        connection.put("custom_fields/#{custom_field_id}") do |f|
          f.params['label'] = options[:label]
        end
      end

    end
  end
end
