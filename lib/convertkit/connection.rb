require "faraday"
require "faraday_middleware"
require "json"

module Convertkit
  class Connection
    attr_reader :http_connection

    def initialize(api_key:, api_secret:)
      @http_connection = faraday_connection(api_key, api_secret)
    end

    def content_type
      "application/vnd.api+json"
    end

    def get(*args, &blk)
      request(:get, *args, &blk)
    end

    def post(*args, &blk)
      request(:post, *args, &blk)
    end

    def put(*args, &blk)
      request(:put, *args, &blk)
    end

    def delete(*args, &blk)
      request(:delete, *args, &blk)
    end

    private

    def request(method, *args, &blk)
      http_connection.public_send(method, *args, &blk)
    end

    def faraday_connection(api_key, api_secret)
      @_faraday_connection ||= Faraday.new do |f|
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
