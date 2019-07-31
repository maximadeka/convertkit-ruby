require "spec_helper"

describe Convertkit do
  it 'has a version number' do
    expect(Convertkit::VERSION).not_to be nil
  end

  describe "#configure" do
    before do
      @old_configuration = Convertkit.configuration.dup
    end

    after do
      Convertkit.configuration = @old_configuration
    end

    it "sets the api_secret value" do
      Convertkit.configure do |config|
        config.api_secret = "new_secret"
      end

      expect(Convertkit.configuration.api_secret).to eql("new_secret")
    end

    it "sets the api_key value" do
      Convertkit.configure do |config|
        config.api_key = "new_key"
      end

      expect(Convertkit.configuration.api_key).to eql("new_key")
    end

    it "sets the timeout value" do
      Convertkit.configure do |config|
        config.timeout = 10
      end

      expect(Convertkit.configuration.timeout).to eql(10)
    end

    it "sets the open_timeout value" do
      Convertkit.configure do |config|
        config.open_timeout = 10
      end

      expect(Convertkit.configuration.open_timeout).to eql(10)
    end
  end
end
