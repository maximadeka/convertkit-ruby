require "spec_helper"
require "base64"

module Convertkit
  describe Client do
    before :each do
      Convertkit.configure do |config|
        config.api_secret = "7ODslJwW6CbZyQiurW90Samr5-hnLRk4C8m0ngh6xng"
        config.api_key = "NKN6OZ--XGOzjEeTRC-ybg"
      end
      @client = Convertkit::Client.new
    end
    
    describe "#initialize" do
      it "has a default api_secret value" do
        expect(@client.api_secret).to eq("7ODslJwW6CbZyQiurW90Samr5-hnLRk4C8m0ngh6xng")
      end
      
      it "has a default api_key value" do
        expect(@client.api_key).to eq("NKN6OZ--XGOzjEeTRC-ybg")
      end
    end
    
    context "authorization" do
      it "uses api key" do
        @client.api_secret = nil

        expect(@client.connection.params["api_key"]).to eq("NKN6OZ--XGOzjEeTRC-ybg")
      end
      
      it "uses api secret" do
        @client.api_key = nil
        
        expect(@client.connection.params["api_secret"]).to eq("7ODslJwW6CbZyQiurW90Samr5-hnLRk4C8m0ngh6xng")
      end
    end
  end
end