module Presto
  class LoadRelationshipsAttributes
    def initialize(model: nil)
      @klass = model
      @resp = {}
    end

    def klass_relationships
      @klass.reflect_on_all_associations.each do |relationship|
        create_params_for_association(relationship)
      end
      @resp
    end

    def create_params_for_association(relationship)
      self.class.send :define_method, "#{relationship.macro}_attributes".to_sym do |relationship|
        attributes = relationship.klass.column_names.map{ |column| column.to_sym }
        if relationship.options.any? && relationship.options.has_key?(:through)
          self.send("#{relationship}_through_attributes".to_sym, relationship, attributes)
        else
          self.send("#{relationship}_basic_attributes".to_sym, relationship, attributes)
        end
      end

      self.class.send :define_method, "#{relationship}_through_attributes".to_sym do |relationship, attributes|
        @resp["#{relationship.options[:through]}_attributes".to_sym] << {"#{relationship.plural_name}_attributes".to_sym => attributes}
      end

      self.class.send :define_method, "#{relationship}_basic_attributes".to_sym do |relationship, attributes|
        @resp["#{relationship.plural_name}_attributes".to_sym] = attributes
      end

      #if Presto.module_eval("load_#{relationship.macro}_relationships")
      if Presto.registry.has_key?(relationship.active_record.to_s.downcase.to_sym) #Return the Model name as a sym e.g: :post, :comment
        if Presto.registry[relationship.active_record.to_s.downcase.to_sym]["load_#{relationship.macro}_relationships".to_sym]
          self.send("#{relationship.macro}_attributes".to_sym, relationship)
        end
      elsif Presto.module_eval("load_#{relationship.macro}_relationships")
        self.send("#{relationship.macro}_attributes".to_sym, relationship)
      end
    end
  end
end
