require "convertkit/client/account"
require "convertkit/client/custom_fields"
require "convertkit/client/forms"
require "convertkit/client/sequences"
require "convertkit/client/subscribers"
require "convertkit/client/webhooks"
require "convertkit/client/tags"
require "convertkit/connection"

module Convertkit
  class Client
    include Account
    include CustomFields
    include Forms
    include Sequences
    include Subscribers
    include Webhooks
    include Tags

    attr_accessor :api_secret, :api_key

    def initialize( api_key=nil, api_secret=nil )
      @api_secret = api_secret || Convertkit.configuration.api_secret
      @api_key = api_key || Convertkit.configuration.api_key
    end

    def connection
      @connection ||= Connection.new(api_key: api_key, api_secret: api_secret)
    end
  end
end
