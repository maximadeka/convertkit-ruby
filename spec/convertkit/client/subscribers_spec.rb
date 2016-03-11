require "spec_helper"

module Convertkit
  class Client
    describe Subscribers do
      
      before do
        @stubs = Faraday::Adapter::Test::Stubs.new
        
        @connection = Faraday.new do |builder|
          builder.adapter :test, @stubs
        end
        
        Convertkit.configure do |config|
          config.api_secret = "api_secret"
          config.api_key = "api_key"
        end
        
        @client = Convertkit::Client.new
      end
      
      context "#subscribers" do
        before do
          @response_status = 200
          @response_body = stub
          
          @stubs.get "/subscribers" do
            [@response_status, {}, @response_body]
          end
        end
      end
    
      it "sends the right request" do
        expected = Convertkit::Response.new(@request_status, @response_body)
        expect(@client.subscribers).to eql(expected)
      end

    end
  end
end