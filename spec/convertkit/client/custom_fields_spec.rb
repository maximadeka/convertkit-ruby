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

      describe '#add_custom_field' do
        it 'returns the new custom_field', :vcr do
          VCR.use_cassette 'new_custom_field' do
            @custom_field = @client.add_custom_field(label: 'Occupation')
            expect(@custom_field.body['key']).to eql 'occupation'
          end
        end
      end

    end
  end
end
