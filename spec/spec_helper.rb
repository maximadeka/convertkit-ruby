$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'convertkit'
require "dotenv"
Dotenv.load(".env.local")

require 'webmock/rspec'
require 'vcr'

Convertkit.configure do |config|
  config.api_secret = ENV["API_SECRET"]
  config.api_key = ENV["API_KEY"]
end

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data("<API_SECRET>") { ENV["API_SECRET"] }
  config.filter_sensitive_data("<API_KEY>") { ENV["API_KEY"] }
  config.allow_http_connections_when_no_cassette = true
end

WebMock.allow_net_connect!


