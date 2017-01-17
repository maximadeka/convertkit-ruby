require "spec_helper"

module Convertkit
  class Client
    describe Sequences do
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
    end
  end
end
