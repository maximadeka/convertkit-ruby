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
  end
end
