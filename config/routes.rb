# Presto::Config::Model.all.each { |model| puts model }
Presto::Engine.routes.draw do
  get '/', controller: :dashboard, action: :index, as: :dashboard
  scope 'models/:name/' do
    resources :items
  end
end
