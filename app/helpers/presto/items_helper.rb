module Presto
  module ItemsHelper
    def th_item(colum_name)
      return colum_name unless colum_name.include?("_id")
      colum_name.gsub("_id","")
    end

    def td_item(model,name)
      return model.send(name.to_sym) unless name.include?("_id")
      val= model.send(name.to_sym)
      link_to val, edit_item_path(name.gsub("_id",""), val)
    end
  end
end
