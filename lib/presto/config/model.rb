require 'active_record'

module Presto
  module Config
    class Model
      class << self
        def all
          ActiveRecord::Base.connection.
            tables.reject { |model| model == 'schema_migrations' }
        end
      end
    end
  end
end
