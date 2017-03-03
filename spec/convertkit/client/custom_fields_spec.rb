require "spec_helper"

module Convertkit
  class Client
    describe CustomFields do
      before do
        @client = Convertkit::Client.new
      end

      describe "#custom_fields" do
        it "fetches custom fields", :vcr do
          VCR.use_cassette 'get_custom_fields' do
            @custom_fields = @client.custom_fields
            expect(@custom_fields.count).to eq(1)
            expect(@custom_fields.first["label"]).to eq('Phone Number')
          end
        end
      end
    end
  end
end
