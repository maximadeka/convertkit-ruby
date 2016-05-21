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
      		expect(@client.sequences.success?).to be_truthy

      		expect(@client.sequences.body).to_not eql({"error"=>"Authorization Failed",
																										 "message"=>"API Key not present"})
      	end
      end

      describe "#add_subscriber_to_sequence" do
      	it "sends the right request" do
      		sequence_id = "15402"
      		email = "rkcudjoe@gmail.com"

      		expect(@client.add_subscriber_to_sequence(sequence_id, email,
																										first_name: "Raymond Cudjoe",
					 																					tags: "26471,45372")).to be_truthy

      		expect(@client.add_subscriber_to_sequence(sequence_id, email).body).to_not eql({"error"=>"Missing parameter",
																																													"message"=>"Subscriber email is required"})
      	end
      end
		end
	end
end
