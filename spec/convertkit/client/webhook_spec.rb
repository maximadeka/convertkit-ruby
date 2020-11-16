require "spec_helper"
require "securerandom"

module Convertkit
  class Client
    describe Webhooks do
      before do
        Convertkit.configure do |config|
          config.api_secret = ENV["API_SECRET"]
          config.api_key = ENV["API_KEY"]
        end

        @client = Convertkit::Client.new
        @url = "https://webhook.site/2bc3b03e-0f34-4a00-b2a9-028eff304f50"
        @events = {"name": "subscriber.subscriber_activate"}
        @rule_id = 1175937
      end

      describe "#subscribers" do
        it "sends the right request" do
          r = @client.webhooks
          expect(r.success?).to be_truthy
          expect(r.body).to_not eql({"error"=>"Authorization Failed", "message"=>"API Key not present"})
        end
      end

      describe "#create_webhook" do
        it "creates a webhook" do
          url = "https://example.com/#{SecureRandom.hex}"
          webhook = @client.create_webhook(url, @events)

          expect(webhook["rule"]["target_url"]).to eq(url)
        end
      end

      describe "#remove_webhook" do
        it "removes a webhook" do
          webhook = @client.remove_webhook(@rule_id)

          expect(webhook["success"]).to be_truthy
        end
      end
    end
  end
end
