module Presto
  module ItemsHelper
    def has_nested_relationship?
       Presto::nested_attributes
    end

    def th_item(q,colum_name)
      return sort_link(q,colum_name) unless colum_name.include?("_id")
      sort_link(q,colum_name,colum_name.gsub("_id",""))
    end

    def td_item(model,name)
      return model.send(name.to_sym) unless name.include?("_id")
      val= model.send(name.to_sym)
      link_to val, edit_item_path(name.gsub("_id",""), val)
    end
  end
end
