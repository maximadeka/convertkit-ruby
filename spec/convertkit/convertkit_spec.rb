require "spec_helper"

describe Convertkit do
  it 'has a version number' do
    expect(Convertkit::VERSION).not_to be nil
  end

  describe "#configure" do
    before do
      @old_configuration = Convertkit.configuration.dup

      Convertkit.configure do |config|
        config.api_secret = "new_secret"
        config.api_key = "new_key"
      end
    end

    after do
      Convertkit.configuration = @old_configuration
    end

    it "sets the api_secret value" do
      expect(Convertkit.configuration.api_secret).to eql("new_secret")
    end

    it "sets the api_key value" do
      expect(Convertkit.configuration.api_key).to eql("new_key")
    end
  end
end
