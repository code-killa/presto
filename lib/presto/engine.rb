module Presto
  class Engine < ::Rails::Engine
    isolate_namespace Presto
    engine_name 'presto'
  end
end
