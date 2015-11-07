module Presto
  class Admin
    cattr_accessor :definition_file_paths
    self.definition_file_paths = %w(app/presto)

    LOAD_HAS_MANY_RELATIONSHIPS = true
    LOAD_HAS_ONE_RELATIONSHIPS = true
    LOAD_BELONGS_TO_RELATIONSHIPS = true

    def self.descendants
      ObjectSpace.each_object(Class).select { |klass| klass < self }
    end

    def self.child?(klass)
      descendants.include? klass
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

