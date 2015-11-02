module Presto
  module ApplicationHelper
    def model_list
      Presto::Config::Model.all
    end
  end
end
