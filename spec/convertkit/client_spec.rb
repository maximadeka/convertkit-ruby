require "spec_helper"
require "base64"

module Convertkit
  describe Client do
    before :each do
      @client = Convertkit::Client.new
    end

    describe "#initialize" do
      it "has a default api_secret value" do
        expect(@client.api_secret).to eq(ENV["API_SECRET"])
      end

      it "has a default api_key value" do
        expect(@client.api_key).to eq(ENV["API_KEY"])
      end
    end

    context "authorization" do
      it "uses api key" do
        @client.api_secret = nil

        expect(@client.connection.params["api_key"]).to eq(ENV["API_KEY"])
      end

      it "uses api secret" do
        @client.api_key = nil

        expect(@client.connection.params["api_secret"]).to eq(ENV["API_SECRET"])
      end
    end
  end
end
