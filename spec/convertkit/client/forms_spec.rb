require "spec_helper"

module Convertkit
  class Client
    describe Sequences do
      before do
        @client = Convertkit::Client.new
      end

      describe "#forms" do
        it "fetches forms", :vcr do
          #stub = stub_request(:get, "https://api.convertkit.com/v3/forms")
          VCR.use_cassette 'forms' do
            @forms = @client.forms
          end
          #expect(stub).to have_been_made.once
        end
      end
    end
  end
end
