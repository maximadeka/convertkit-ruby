require "spec_helper"
require "securerandom"

module Convertkit
  class Client
    describe Tags do
      before do
        Convertkit.configure do |config|
          config.api_secret = ENV["API_SECRET"]
          config.api_key = ENV["API_KEY"]
        end

        @client = Convertkit::Client.new
      end

      describe "#tags" do
        it "sends the right request" do
          r = @client.tags
          expect(r.success?).to be_truthy
          expect(r.body).to_not eql({"error"=>"Authorization Failed","message"=>"API Key not present"})
        end
      end

      describe "#add_subscriber_to_tag" do
        it "sends the right request" do
          tag_id = ENV['TAG_ID']
          email = "crt-tags+#{Time.now.to_i}@example.com"

          r = @client.add_subscriber_to_tag(tag_id, email)
          expect(r.success?).to be_truthy
          expect(r.body).to_not eql({"error"=>"Missing parameter","message"=>"Subscriber email is required"})
        end
      end

      describe "#remove_tag_from_subscriber" do
        it "sends the right request" do
          subscriber_id = ENV['SUBSCRIBER_ID']
          tag_id = ENV['TAG_ID']
          
          r = @client.remove_tag_from_subscriber(tag_id, subscriber_id)
          expect(r.success?).to be_truthy
          expect(r.body).to_not eql({"error"=>"Not Found", "message"=>"The entity you were trying to find doesn't exist"})
        end
      end

      describe "#remove_tag_from_subscriber_by_email" do
        it "sends the right request" do
          tag_id = ENV['TAG_ID']
          email = "crt-tags+#{Time.now.to_i}@example.com"
          
          r = @client.remove_tag_from_subscriber_by_email(tag_id, email)
          expect(r.success?).to be_truthy
          expect(r.body).to_not eql({"error"=>"Missing parameter","message"=>"Subscriber email is required"})
        end
      end

      describe "#create_tag" do
        it "creates a tag" do
          tag_name = "tag-#{SecureRandom.hex}"

          tag = @client.create_tag(tag_name)

          expect(tag["name"]).to eq(tag_name)
        end
      end

      describe "#create_tags" do
        it "creates multiple tags" do
          tag_name1 = "tag-#{SecureRandom.hex}"
          tag_name2 = "tag-#{SecureRandom.hex}"

          tags = @client.create_tags([tag_name1, tag_name2])

          expect(tags[0]["name"]).to eq(tag_name1)
          expect(tags[1]["name"]).to eq(tag_name2)
        end
      end

      describe "#subscriptions_to_tag" do
        it "sends the right request" do
          tag_id = ENV['TAG_ID']

          r = @client.subscriptions_to_tag(tag_id)
          expect(r.success?).to be_truthy
          expect(r.body).to_not eql({"error"=>"Authorization Failed", "message"=>"API Key not present"})
        end
      end
    end
  end
end
