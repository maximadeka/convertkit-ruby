require "spec_helper"

module Convertkit
  class Client
    describe Forms do
      before do
        @client = Convertkit::Client.new
      end

      describe "#forms" do
        it "fetches forms", :vcr do
          VCR.use_cassette 'forms' do
            @forms = @client.forms
            expect(@forms.count).to eq(1)
            expect(@forms.first["id"]).to eq(133233)
          end
        end
      end

      describe "#add_subscriber_to_form" do
        it "returns new subscriber data", :vcr do
          VCR.use_cassette 'add_subscriber_to_form' do
            @subscriber = @client.add_subscriber_to_form(175221, 'test@example.com')
            expect(@subscriber.body['subscription']).to be_truthy
          end
        end
      end
    end
  end
end
