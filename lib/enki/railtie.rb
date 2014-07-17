# encoding: utf-8

require 'rails'

module Enki
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/compile_docs.rake'
    end
  end
end
