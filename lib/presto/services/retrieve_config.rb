module Presto
  module Services
    class RetrieveConfig
      def initialize(active_record_klass: nil, config: nil)
        @klass = active_record_klass
        @config = config
      end

      def accpet_this_config?
        admin_class = get_admin_class_name(@klass)
        admin_class.const_get(@config.upcase) if admin_class
      end

      private
        def get_admin_class_name(active_record_klass)
          klass_name = "Presto::#{active_record_klass}"
          return unless Object.const_defined?(klass_name)
          return unless Presto::Admin.child?(klass_name.constantize)
          klass_name.constantize
        end
    end
  end
end

# Presto::Services::RetrieveConfig.new(active_record_klass: Post, config: "load_has_many_relationships").accpet_this_config?
