require "convertkit/client/sequences"
require "convertkit/client/subscribers"
require "convertkit/client/tags"
require "convertkit/client/forms"
require "faraday"
require "faraday_middleware"
require "json"

module Convertkit
  class Client
    include Subscribers
    include Sequences
    include Tags
    include Forms

    attr_accessor :api_secret, :api_key

    def initialize( api_key=nil, api_secret=nil )
      @api_secret = api_secret || Convertkit.configuration.api_secret
      @api_key = api_key || Convertkit.configuration.api_key
    end

    def content_type
      'application/vnd.api+json'
    end

    def connection
      @connection ||= Faraday.new do |f|
        f.url_prefix = "https://api.convertkit.com/v3/"
        f.adapter :net_http

        f.headers['User-Agent'] = "Convertkit-Ruby v#{Convertkit::VERSION}"
        f.headers['Content-Type'] = content_type
        f.headers['Accept'] = "*/*"

        f.params['api_secret'] = api_secret if api_secret
        f.params['api_key'] = api_key if api_key

        f.response :json, content_type: /\bjson$/
      end
    end
  end
end
