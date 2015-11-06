require "presto/engine"
require 'presto/config/model'
require 'formtastic'
require 'presto/settings'
require 'will_paginate'
require 'will_paginate-bootstrap'
require 'haml'
require 'ransack'

module Presto
  def self.setup
    yield self
  end
  class PrestoRailtie < Rails::Railtie
    initializer "new_initialization_behavior" do |app|
      app.routes.append do
        # get "/pricing" => "presto/welcome#demo"
      end
    end
  end
end

