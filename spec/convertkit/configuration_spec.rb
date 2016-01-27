require "spec_helper"

module Convertkit
  describe Configuration do
    describe "#initialize" do
      before do
        Convertkit.configure do |config|
          config.api_secret = "api_secret"
          config.api_key = "api_key"
        end
      end
      
      it "has a default api_secret value" do
        expect(Convertkit.configuration.api_secret).to eql("api_secret")
      end
      
      it "has a default api_key value" do
        expect(Convertkit.configuration.api_key).to eql("api_key")
      end
    end
  end
end