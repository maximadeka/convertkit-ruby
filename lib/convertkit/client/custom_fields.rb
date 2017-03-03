module Convertkit
  class Client
    module CustomFields

      def custom_fields
        connection.get("custom_fields").body["custom_fields"]
      end
      
    end
  end
end
