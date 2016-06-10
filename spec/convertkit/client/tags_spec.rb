require "spec_helper"

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
    end
  end
end
