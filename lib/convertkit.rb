require "convertkit/version"
require "convertkit/configuration"
require "convertkit/client"
require "dotenv"
Dotenv.load(".env.local")

module Convertkit
  class << self
    attr_accessor :configuration
  end
  
  def self.configuration
    @configuration ||= Configuration.new
  end
  
  def self.configure
    yield(configuration)
  end
end