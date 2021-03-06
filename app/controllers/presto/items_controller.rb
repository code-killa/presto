require_dependency "presto/application_controller"
require_dependency "presto/load_relationships_attributes"

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
      redirect_to items_path(name: @klass)
    end

    private
    def load_items
      @q = item_scope.ransack(params[:q])
      @item_list = @q.result(distinct: true).paginate(page: params[:page])
    end

    def load_item
      @item ||= item_scope.find(params[:id])
    end

    def build_item
      @item ||= item_scope.build
      @item.attributes = item_params
      @klass.nested_attributes_options.keys.each do |nested_key|
        1.times { nested_relationship(nested_key).build } if Presto::nested_attributes && nested_relationship(nested_key).empty?
      end
    end

    def save_item
      redirect_to item_path(name: @klass.to_s.downcase, id: @item.id) if @item.save
    end

    def item_scope
      @klass.all
    end

    def item_params
      item_params = params[params[:name]]
      item_params ? item_params.permit(columns_names) : {}
    end

    def load_class
      @klass = params[:name].classify.constantize
    end

    def columns_names
      @klass_column_names ||= @klass.column_names.reject { |item| item == "id" }
      @klass_column_names.map { |column| column.to_sym } << Presto::LoadRelationshipsAttributes.new(model: @klass).klass_relationships
    end

    def nested_relationship(key)
      @item.send(key)
    end
  end
end
