require 'enki/version'
require 'logger'
require 'erb'
require 'yaml'

module Enki
  class << self
    attr_writer :configuration
  end

  def self.logger
    @logger ||= Logger.new(STDOUT)
  end

  def self.logger=(logger)
    @logger = logger
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
    attr_accessor :confluence_url,
      :confluence_user,
      :confluence_password,
      :confluence_space

    attr_accessor :snowcrash_binary
    attr_accessor :erb_template

    def initialize
      @snowcrash_path = "snowcrash"
      @erb_template = "lib/templates/default.html.erb"
    end
  end
end

require 'enki/confluence.rb'
require 'enki/redcarpenter.rb'
require 'enki/snowcrasher.rb'

require 'enki/railtie.rb' if defined?(Rails) && Rails::VERSION::MAJOR > 2
