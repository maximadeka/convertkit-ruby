require "spec_helper"

module Convertkit
  class Client
    describe Sequences do
      before do
        Convertkit.configure do |config|
          config.api_secret = ENV["API_SECRET"]
          config.api_key = ENV["API_KEY"]
        end

        @client = Convertkit::Client.new
      end

      describe "#sequences" do
        it "sends the right request" do
          r = @client.sequences
          expect(r.success?).to be_truthy
          expect(r.body).to_not eql({"error"=>"Authorization Failed","message"=>"API Key not present"})
        end
      end

      describe "#add_subscriber_to_sequence" do
        it "sends the right request" do
          sequence_id = ENV['SEQUENCE_ID']
          email = "crt-sequences+#{Time.now.to_i}@example.com"
          tags = ENV['TAGS']

          r = @client.add_subscriber_to_sequence(sequence_id, email, tags: tags)
          expect(r.success?).to be_truthy
          expect(r.body).to_not eql({"error"=>"Missing parameter","message"=>"Subscriber email is required"})
        end
      end
    end
  end
end
