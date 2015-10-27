module Presto
  class LoadRelationshipsAttributes
    def initialize(model: nil)
      @klass = model
      @resp = {}
    end

    def klass_relationships
      @klass.reflect_on_all_associations.each do |relationship|
        case relationship.macro.to_s
        when "has_many"
          has_many_attributes(relationship) if Presto::load_has_many_relationships
        when "has_one"
          has_one_attributes(relationship) if Presto::load_has_one_relationships
        end
      end
      @resp
    end

    private
      def has_many_attributes(relationship)
        if relationship.options.has_key? :through
          has_many_through_attributes(relationship)
        else
          has_many_basic_attributes(relationship)
        end
      end

      def has_many_basic_attributes(relationship)
        attributes = relationship.klass.column_names.map{ |column| column.to_sym }
        @resp["#{relationship.plural_name}_attributes".to_sym] = attributes
      end

      def has_many_through_attributes(relationship)
        attributes = relationship.klass.column_names.map{ |column| column.to_sym }
        @resp["#{relationship.options[:through]}_attributes".to_sym] << {"#{relationship.plural_name}_attributes": attributes}
      end

      def has_one_attributes(relationship)
        if relationship.options.has_key? :through
          has_one_through_attributes(relationship)
        else
          has_one_basic_attributes(relationship)
        end
      end

      def has_one_basic_attributes(relationship)
        attributes = relationship.klass.column_names.map{ |column| column.to_sym }
        @resp["#{relationship.name}_attributes".to_sym] = attributes
      end

      def has_one_through_attributes(relationship)
        attributes = relationship.klass.column_names.map{ |column| column.to_sym }
        @resp["#{relationship.options[:through]}_attributes".to_sym] << {"#{relationship.plural_name}_attributes": attributes}
      end
  end
end
