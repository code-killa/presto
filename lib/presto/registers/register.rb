module Presto
  mattr_accessor :registry
  @@registry = {}

  class Register
    cattr_accessor :definition_file_paths
    self.definition_file_paths = %w(app/presto_admin/registers app/models/presto_admin_registers)

    def self.register(&block)
      self.new.instance_eval(&block)
    end

    def add(klass, config = {})
      Presto.registry[klass] = config
    end

    def self.find_definitions
      absolute_definition_file_paths = definition_file_paths.map { |path| File.expand_path(path) }
      absolute_definition_file_paths.uniq.each do |path|
        load("#{path}.rb") if File.exist?("#{path}.rb")

        if File.directory? path
          Dir[File.join(path, '**', '*.rb')].sort.each do |file|
            load file
          end
        end
      end
    end

  end
end

# Asi seria como agregarian las configuraciones por modelo
#
# Presto::Register.register do
#   add :post, {
#     load_has_many_relationships: true
#   }
# end
