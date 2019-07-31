require "convertkit/errors"
require "faraday"
require "faraday_middleware"
require "json"

module Convertkit
  class Connection
    attr_reader :http_connection

    def initialize(api_key: nil, api_secret: nil)
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

    def faraday_connection(api_key, api_secret)
      Faraday.new do |f|
        f.url_prefix = "https://api.convertkit.com/v3/"
        f.adapter :net_http

        f.options.timeout = Convertkit.configuration.timeout
        f.options.open_timeout = Convertkit.configuration.open_timeout

        f.headers['User-Agent'] = "Convertkit-Ruby v#{Convertkit::VERSION}"
        f.headers['Content-Type'] = content_type
        f.headers['Accept'] = "*/*"

        f.params['api_secret'] = api_secret if api_secret
        f.params['api_key'] = api_key if api_key

        f.response :json, content_type: /\bjson$/
      end
    end

    def request(method, *args, &blk)
      begin
        response = http_connection.public_send(method, *args, &blk)
      rescue Faraday::Error => e
        raise ConnectionError.new(e)
      end

      unless response.success?
        handle_error_response(response)
      end

      response
    end

    def handle_error_response(response)
      case response.status
      when 401
        raise AuthorizationError.new(response.body)
      when 404
        raise NotFoundError.new(response.body)
      when 422
        raise UnprocessableEntityError.new(response.body)
      when 429
        raise TooManyRequestsError.new(response.body)
      when 500..599
        raise ServerError.new(response.body)
      else
        raise UnknownError.new(response.body)
      end
    end
  end
end
