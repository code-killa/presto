require_dependency "presto/application_controller"

module Presto
  class ItemsController < ApplicationController

    before_action :load_class
    def index
      load_items
    end

    def show
      load_item
    end

    def new
      build_item
    end

    def create
      build_item
      save_item or render 'new'
    end

    def edit
      load_item
      build_item
    end

    def update
      load_item
      build_item
      save_item or render 'edit'
    end

    def destroy
      load_item
      @item.destroy
      redirect to admin_item_path
    end

    private
    def load_items
      @object_list ||= item_scope.to_a
    end

    def load_item
      @object ||= item_scope.find(params[:id])
    end

    def build_item
      @object ||= item_scope.build
      @object.attributes = item_params
    end

    def save_item
      redirect_to item_path(name: @klass.to_s.downcase, id: @object.id) if @object.save
    end

    def item_scope
      @klass.all
    end

    def item_params
      item_params = params[params[:name]]
      item_params ? item_params.permit(:title): {}
    end

    def load_class
      @klass = params[:name].classify.constantize
    end

  end
end
