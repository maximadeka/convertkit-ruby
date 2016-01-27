require "spec_helper"
require "base64"

module Convertkit
  describe Client do
    before :each do
      Convertkit.configure do |config|
        config.api_secret = "client_secret"
        config.api_key = "client_key"
      end
      @client = Convertkit::Client.new
    end
    
    describe "#initialize" do
      it "has a default api_secret value" do
        expect(@client.api_secret).to eq("client_secret")
      end
      
      it "has a default api_key value" do
        expect(@client.api_key).to eq("client_key")
      end
    end
    
    describe "#generate_resource" do
      before do
        @key =  :subscribers
        @data = { email: "jane@domain.com", first_name: "Jane" }
      end
      
      it "returns a JSON API payload" do
        expect(@client.generate_resource(@key, @data)).to eql({@key => [@data]})
      end
    end
    
    context "authorization" do
      it "uses Basic authentication" do
        @client.api_secret = nil
        
        header = "Basic #{Base64.encode64(@client.api_key + ":")}".strip
        expect(@client.connection.headers["Authorization"]).to eq(header)
      end
      
      it "uses Bearer token authentication" do
        @client.api_key = nil
        
        header = "Bearer #{@client.api_secret}"
        expect(@client.connection.headers["Authorization"]).to eq(header)
      end
    end
  end
end