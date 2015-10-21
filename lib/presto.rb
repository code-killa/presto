require "presto/engine"
require 'presto/config/model'
require 'formtastic'
require 'presto/settings'
require 'will_paginate'
require 'will_paginate-bootstrap'

module Presto
  class PrestoRailtie < Rails::Railtie
    initializer "new_initialization_behavior" do |app|
      app.routes.append do
        get "/" => "presto/welcome#index"
        get "/pricing" => "presto/welcome#demo"
      end
    end
  end
end

