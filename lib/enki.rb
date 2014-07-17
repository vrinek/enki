require 'enki/version'
require 'logger'
require 'erb'
require 'yaml'
require 'confluencer'

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
    attr_accessor :confluence_url, :confluence_user, :confluence_password
    attr_accessor :snowcrash_binary

    def initialize
      @snowcrash_path = "snowcrash"
    end
  end
end
