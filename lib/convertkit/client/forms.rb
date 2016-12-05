module Convertkit
  class Client
    module Forms
      def forms
        connection.get("forms").body["forms"]
      end
    end
  end
end
