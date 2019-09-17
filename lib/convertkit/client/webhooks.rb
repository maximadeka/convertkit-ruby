module Convertkit
  class Client
    module Webhooks
      def create_webhook(url, events)
        response = connection.post("automations/hooks") do |f|
          f.params['target_url'] = url
          f.params['event'] = events
        end
        response.body
      end

      def remove_webhook(rule_id)
        connection.delete("automations/hooks/#{rule_id}").body
      end
    end
  end
end
