module Convertkit
  class Error < StandardError; end

  class AuthorizationError < Error; end
  class ConnectionError < Error; end
  class NotFoundError < Error; end
  class ServerError < Error; end
  class TooManyRequestsError < Error; end
  class UnknownError < Error; end
  class UnprocessableEntityError < Error; end
end
