module Presto
  mattr_accessor :demo
  @@demo = "value of var demo inside de gem"

  mattr_accessor :load_has_many_relationships
  @@load_has_many_relationships = true

  mattr_accessor :load_has_one_relationships
  @@load_has_one_relationships = true

  mattr_accessor :load_belongs_to_relationships
  @@load_belongs_to_relationships = false

  mattr_accessor :nested_attributes
  @@nested_attributes = true
end
