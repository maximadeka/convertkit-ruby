require "spec_helper"

module Convertkit
  class Client
    describe Subscribers do
      before do
        Convertkit.configure do |config|
          config.api_secret = ENV["API_SECRET"]
          config.api_key = ENV["API_KEY"]
        end

        @client = Convertkit::Client.new
      end

      describe "#subscribers" do
        it "sends the right request" do
          r = @client.subscribers
          expect(r.success?).to be_truthy
          expect(r.body).to_not eql({"error"=>"Authorization Failed", "message"=>"API Key not present"})
        end
      end

      describe "#subscriber" do
        it "sends the right request" do
          subscriber_id = ENV['SUBSCRIBER_ID']

          r = @client.subscriber(subscriber_id)
          expect(r.success?).to be_truthy
          expect(r.body).to_not eql({"error"=>"Not Found", "message"=>"The entity you were trying to find doesn't exist"})
        end
      end

      describe "#unsubscribe" do
        it "sends the right request" do
          tag_id = ENV['TAG_ID']
          email = "crt-subscribers+#{Time.now.to_i}@example.com"
          @client.add_subscriber_to_tag(tag_id, email)

          r = @client.unsubscribe(email)
          expect(r.success?).to be_truthy
          expect(r.body).to_not eql({"error"=>"Not Found", "message"=>"The entity you were trying to find doesn't exist"})
        end
      end

      describe "#remove_tag_from_subscriber" do
        it "removes tag from a subscriber" do
          tag_id = ENV['TAG_ID']
          email = "crt-subscribers+#{Time.now.to_i}@example.com"
          subscriber = @client.add_subscriber_to_tag(tag_id, email).body["subscription"]["subscriber"]

          expect {
            @client.remove_tag_from_subscriber(subscriber["id"], tag_id)
          }.to change {
            @client.connection.get("tags/#{tag_id}/subscriptions").body["total_subscriptions"]
          }.by(-1)
        end
      end
    end
  end
end
