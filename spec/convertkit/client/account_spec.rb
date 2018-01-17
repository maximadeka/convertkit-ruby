require "spec_helper"

module Convertkit
  class Client
    describe Account do
      before do
        @client = Convertkit::Client.new
      end

      describe "#account" do
        it "fetches account information" do
          VCR.use_cassette "account" do
            @account = @client.account

            expect(@account["primary_email_address"]).to be_truthy
          end
        end
      end
    end
  end
end
