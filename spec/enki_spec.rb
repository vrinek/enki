require 'spec_helper'

describe Enki do
  describe "#configure" do
    it "sets the confluence user" do
      Enki.configure do |conf|
        conf.confluence_user = "conf_user"
      end

      expect(Enki.configuration.confluence_user).to eql "conf_user"
    end

    it "sets the confluence password" do
      Enki.configure do |conf|
        conf.confluence_password = "conf_pass"
      end

      expect(Enki.configuration.confluence_password).to eql "conf_pass"
    end

    it "sets the confluence url" do
      Enki.configure do |conf|
        conf.confluence_url = "conf_url"
      end

      expect(Enki.configuration.confluence_url).to eql "conf_url"
    end

    it "sets the confluence space" do
      Enki.configure do |conf|
        conf.confluence_url = "conf_space"
      end

      expect(Enki.configuration.confluence_space).to eql "conf_space"
    end

    it "sets the erb template path" do
      # has a default template path
      expect(Enki.configuration.erb_template).to eql "lib/templates/default.html.erb"

      Enki.configure do |conf|
        conf.erb_template = "template_path"
      end

      expect(Enki.configuration.erb_template).to eql "template_path"
    end
  end

  describe "logging" do
    it "sets the logger" do
      logger = Logger.new(STDOUT)
      Enki.logger = logger

      expect(logger).to receive(:log).with("a message")

      Enki.logger.log "a message"
    end
  end
end
