module Convertkit
  class Client
    module Forms
      def forms
        connection.get("forms")
      end
    end
  end
end
