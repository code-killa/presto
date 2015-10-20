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
      @item_list ||= item_scope
    end

    def load_item
      @item ||= item_scope.find(params[:id])
    end

    def build_item
      @item ||= item_scope.build
      @item.attributes = item_params
    end

    def save_item
      redirect_to item_path(name: @klass.to_s.downcase, id: @item.id) if @item.save
    end

    def item_scope
      @klass.all
    end

    def item_params
      item_params = params[params[:name]]
      item_params ? item_params.permit(columns_names): {}
    end

    def load_class
      @klass = params[:name].classify.constantize
    end

    def columns_names
      @klass_column_names ||= @klass.column_names
      @klass_column_names.delete("id")
      @klass_column_names.map { |column| column.to_sym }
    end

  end
end
