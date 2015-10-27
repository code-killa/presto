module Presto
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end

      def mount_engine
        route("mount Presto::Engine => '/admin'")
        template 'initializers/presto.rb', File.join('config', 'initializers', 'presto.rb')
      end

    end

  end
end
