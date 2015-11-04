module Presto
  mattr_accessor :registry
  @@registry = {}

  class Register
    def self.register(&block)
      self.new.instance_eval(&block)
    end

    def add(klass, config = {})
      Presto.registry[klass.to_s.downcase.to_sym] = config
    end
  end
end

# Asi seria como agregarian las configuraciones por modelo
#
# Presto::Register.register do
#   add Post, {
#     load_has_many_relationships: true
#   }
# end
