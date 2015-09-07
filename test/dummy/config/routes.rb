Rails.application.routes.draw do

  mount Presto::Engine => "/presto"
end
