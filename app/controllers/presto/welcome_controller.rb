require_dependency "presto/application_controller"

module Presto
  class WelcomeController < ApplicationController
    def index
      @models = ActiveRecord::Base.descendants.map { |model| model.to_s }
      @models.each { |model| puts model }
      @gems = Bundler.load.specs.map { |spec| spec.name }
    end

    def demo
    end
  end
end
