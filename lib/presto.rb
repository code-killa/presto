require "presto/engine"

module Presto
  class PrestoRailtie < Rails::Railtie
    initializer "new_initialization_behavior" do |app|
      puts "eager load model"
      app.eager_load!
      puts "appending root routes"
      app.routes.append do
        get "/" => "presto/welcome#index"
        get "/pricing" => "presto/welcome#demo"
      end
    end
  end
end

