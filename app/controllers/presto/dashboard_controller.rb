require_dependency "presto/application_controller"

module Presto
  class DashboardController < ApplicationController
    before_action :load_models

    def index
    end

    private
    def load_models
      @models_list = Presto::Config::Model.all
    end

    def load_class
      @klass = params[:name].classify.constantize
    end
  end
end

