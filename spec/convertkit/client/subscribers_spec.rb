require "spec_helper"
require "securerandom"

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

      describe "#update_subscriber" do
        it "updates a subscriber" do
          old_email = "old-email-#{Time.now.to_i}@example.com"
          new_email = "new-email-#{Time.now.to_i}@example.com"
          subscriber_id = @client.add_subscriber_to_tag(ENV["TAG_ID"], old_email).body["subscription"]["subscriber"]["id"]

          response = @client.update_subscriber(subscriber_id, { email_address: new_email })

          subscriber = response["subscriber"]
          expect(subscriber["email_address"]).to eq(new_email)
        end

        it "only updates provided attributes" do
          email = "old-email-#{Time.now.to_i}@example.com"
          first_name = "first_name"
          subscriber_id = @client.add_subscriber_to_tag(ENV["TAG_ID"], email, first_name: first_name).body["subscription"]["subscriber"]["id"]

          response = @client.update_subscriber(subscriber_id)

          subscriber = response["subscriber"]
          expect(subscriber["email_address"]).to eq(email)
          expect(subscriber["first_name"]).to eq(first_name)
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
          email = "#{SecureRandom.hex}@example.com"
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
