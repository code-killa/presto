# Presto::Config::Model.all.each { |model| puts model }
Presto::Engine.routes.draw do
  get '/', controller: :dashboard, action: :index, as: :dashboard
  controller :items do
    get 'models/:name', action: :index, as: :model_index
    get '/models/:name/new',  action: :new, as: :model_new
    post '/:name', controller: :items, action: :create, as: :items
    get 'models/:name/:id', controller: :items, action: :show, as: :item
  end
end
